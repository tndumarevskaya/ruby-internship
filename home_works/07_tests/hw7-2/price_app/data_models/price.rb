# frozen_string_literal: true

# Класс Price представляет цену параметра вм определенного типа.
class Price
  attr_accessor :type, :price

  # Инициализирует новый объект Price с указанным типом и ценой.
  #
  # type - Тип параметра вм (строка).
  # price - Цена товара (число).
  def initialize(type, price)
    @type = type
    @price = price.to_i
  end
end
