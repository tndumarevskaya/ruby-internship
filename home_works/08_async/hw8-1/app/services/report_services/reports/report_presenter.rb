module ReportPresenter
  # Метод для вывода отчета на основе данных о виртуальных машинах
  def self.print_all(report_data_array, arg, hdd_type = nil, n, report_type)
    # Формирование заголовка отчета
    report = {
      "name": "Report #{report_type} for #{n} vms",
      "vms": []
    }
    
    # Итерация по каждому элементу данных отчета
    report_data_array.each do |report_data|
      # Добавление данных отчета в общий отчет
      report[:vms] += print(report_data, arg, hdd_type)
    end
    
    # Возврат сформированного отчета
    report
  end

  # Метод для форматированного вывода данных отчета
  def self.print(report_data, arg, hdd_type = nil)
    output = []
    
    # Вывод заголовка данных
    puts "ID, #{arg}" + (hdd_type ? ", HDD type" : "")
    
    # Итерация по каждой строке данных и их вывод
    report_data.each do |line|
      puts "#{line[:id]}, #{line[:arg]}" + (hdd_type ? ", #{line[:hdd_type]}" : "")
      
      # Формирование объекта виртуальной машины и добавление в выходной массив
      vm = { id: line[:id], "#{arg}": line[:arg] }
      output << vm
    end
    
    # Возврат массива данных
    output
  end
end
