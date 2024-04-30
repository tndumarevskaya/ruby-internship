require "csv"
require_relative '../data_models/vm'

class VMLoader
  # Атрибут только для чтения: массив виртуальных машин
  attr_reader :vms

  # Конструктор класса VMLoader
  # Принимает имя файла в формате CSV по умолчанию
  def initialize(file_name = "app/services/report_services/csv/vms.csv")
    # Инициализация массива виртуальных машин
    @vms = []
    # Загрузка данных из файла
    load_data(file_name)
  end

  # Метод для загрузки данных из CSV файла
  def load_data(file_name)
    # Итерация по каждой строке CSV файла
    CSV.foreach(file_name, headers: false) do |row|
      # Разбор данных строки: id, cpu, ram, hdd_type, hdd_capacity
      id, cpu, ram, hdd_type, hdd_capacity = row.map(&:strip)
      # Создание объекта VM и добавление его в массив виртуальных машин
      @vms << VM.new(id, cpu, ram, hdd_type, hdd_capacity)
    end
  end

  # Метод для добавления тома к виртуальной машине по её идентификатору
  def add_volume(vm_id, volume)
    # Поиск виртуальной машины по id
    vm = @vms.find { |vm| vm.id == vm_id }

    # Возврат nil, если виртуальная машина не найдена
    return nil unless vm

    # Добавление тома к найденной виртуальной машине
    vm.add_volume(volume)
  end

  # Метод для получения списка виртуальных машин по типу жесткого диска
  def get_vms_by_hdd_type(type)
    @vms.select { |vm| vm.hdd_type == type }
  end

  # Метод для получения списка виртуальных машин с дополнительным типом жесткого диска
  # Если hdd_type равен nil, возвращаются все виртуальные машины
  def get_vms_by_additional_hdd_type(hdd_type = nil)
    @vms.select { |vm| vm.volumes.any? { |volume| volume.hdd_type == hdd_type } || hdd_type.nil? }
  end
end
