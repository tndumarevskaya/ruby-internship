class VM
  # Атрибуты доступа для чтения и записи: id, cpu, ram, hdd_type, hdd_capacity и volumes
  attr_accessor :id, :cpu, :ram, :hdd_type, :hdd_capacity, :volumes

  # Конструктор класса VM
  # Принимает пять параметров: id, cpu, ram, hdd_type, hdd_capacity
  def initialize(id, cpu, ram, hdd_type, hdd_capacity)
    # Присваивание значений параметров атрибутам объекта
    @id = id.to_i
    @cpu = cpu.to_i
    @ram = ram.to_i
    @hdd_type = hdd_type
    @hdd_capacity = hdd_capacity.to_i
    # Инициализация атрибута volumes как пустого массива
    @volumes = []
  end

  # Метод добавления объема диска к виртуальной машине
  # Принимает один параметр: volume
  def add_volume(volume)
    # Добавление объема диска к массиву volumes
    @volumes << volume
  end
end
