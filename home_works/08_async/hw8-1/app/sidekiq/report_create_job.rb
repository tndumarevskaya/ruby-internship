require_relative '../services/report_services/reports/report_presenter.rb'
require_relative '../services/report_services/reports/report_creater.rb'

class ReportCreateJob
  include Sidekiq::Job

  # Метод выполнения задачи создания отчета
  def perform(report_id, n = 10, hdd_type = nil)
    # Поиск отчета по идентификатору
    report = Report.find_by_id(report_id)
    
    # Создание объекта для формирования отчета
    report_data = ReportCreater.new()
    
    # Определение типа отчета из самого отчета
    report_type = report[:report_type]
    
    # Установка аргумента по умолчанию
    arg = "Price"

    # Определение типа и выполнение соответствующих операций
    case report_type
    when 'expensive_vm'
      result = report_data.expensive_vm(n)
      hdd_type = nil
    when 'cheap_vm'
      result = report_data.cheap_vm(n)
      hdd_type = nil
    when 'big_volume'
      result = report_data.big_volume(n, hdd_type)
      arg = "HDD capacity"
    when 'additional_volume_number'
      result = report_data.additional_volume_number(n, hdd_type)
      arg = "Additional HDD num"
    when 'additional_volume_capacity'
      result = report_data.additional_volume_capacity(10, hdd_type)
      arg = "Additional HDD capacity"
    end

    # Вывод данных отчета в лог
    Sidekiq.logger.info("Report data: #{result.inspect}")

    # Формирование JSON представления отчета с использованием ReportPresenter
    json_report = ReportPresenter.print_all([result], arg, hdd_type, n, report_type).to_json 
    
    # Обновление тела отчета в базе данных
    report.update(body: json_report)
  rescue StandardError => e
    # Обработка ошибок и обновление тела отчета в случае исключения
    report.update(body: { error: "Ошибка! #{e.message}" }.to_json)
  end
end
