class GrapeApi
  class ReportsApi < Grape::API
    format :json

    # Пространство имен для обработки запросов отчетов
    namespace :reports do
      # Обработчик GET запроса для получения всех отчетов
      get do
        present Report.all, with: GrapeApi::Entities::Report
      end

      # Обработчик POST запроса для создания нового отчета
      params do
        # Опциональный параметр: имя отчета
        optional :name, type: String
        # Опциональный параметр: тип HDD (SSD, SATA, SAS)
        optional :hdd_type, type: String, values: %w[ssd sata sas]
        # Опциональный параметр: значение N
        optional :n_value, type: Integer
        # Обязательный параметр: тип отчета
        requires :report_type, type: Integer, values: [0, 1, 2, 3, 4]
      end
      post do
        begin
          # Создание нового отчета
          report = Report.create(name: params[:name], report_type: params[:report_type])
          # Представление созданного отчета с помощью сущности GrapeApi::Entities::Report
          present report, with: GrapeApi::Entities::Report
        rescue ActiveRecord::RecordInvalid => e
          # Обработка ошибки невалидной записи в базу данных
          error!({ error: e.message }, 422)
        end
        # Асинхронное выполнение задачи создания отчета
        ReportCreateJob.perform_async(report.id, params[:n_value], params[:hdd_type])
      end

      # Обработчик GET запроса для получения отчета по его идентификатору
      route_param :id, type: Integer do
        get do
          # Поиск отчета по идентификатору
          report = Report.find_by_id(params[:id])
          # Обработка случая, когда отчет не найден
          error!({ message: 'Not found' }, 404) unless report
          # Представление найденного отчета с помощью сущности GrapeApi::Entities::Report
          present report, with: GrapeApi::Entities::Report
        end
      end
    end
  end
end
