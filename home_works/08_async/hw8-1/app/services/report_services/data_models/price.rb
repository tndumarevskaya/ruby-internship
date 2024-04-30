class Price
  # Атрибуты доступа для чтения и записи: type и price
  attr_accessor :type, :price

  # Конструктор класса Price
  # Принимает два параметра: тип и цену
  def initialize(type, price)
    # Присваивание значений параметров атрибутам объекта
    @type = type
    @price = price.to_i
  end
end
