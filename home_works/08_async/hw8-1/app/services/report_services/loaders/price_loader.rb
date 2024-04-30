require "csv"
require_relative '../data_models/price'

class PriceLoader
  # Атрибут только для чтения: массив цен
  attr_reader :prices

  # Конструктор класса PriceLoader
  # Принимает имя файла в формате CSV по умолчанию
  def initialize(file_name = "app/services/report_services/csv/prices.csv")
    # Инициализация массива цен
    @prices = []
    # Загрузка данных из файла
    load_data(file_name)
  end

  # Метод для загрузки данных из CSV файла
  def load_data(file_name)
    # Итерация по каждой строке CSV файла
    CSV.foreach(file_name) do |row|
      # Разбор данных строки: тип и цена
      type, price = row.map(&:strip)
      # Создание объекта Price и добавление его в массив цен
      @prices << Price.new(type, price)
    end
  end

  # Метод для получения цены по заданному типу
  def get_price(type)
    # Поиск цены по типу в массиве цен
    @prices.find { |price| price.type == type}.price
  end
end
