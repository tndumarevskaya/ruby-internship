class Volume
  # Атрибуты доступа для чтения и записи: hdd_type, hdd_capacity
  attr_accessor :hdd_type, :hdd_capacity

  # Конструктор класса Volume
  # Принимает два параметра: hdd_type, hdd_capacity
  def initialize(hdd_type, hdd_capacity)
    # Присваивание значений параметров атрибутам объекта
    @hdd_type = hdd_type
    @hdd_capacity = hdd_capacity.to_i
  end
end
