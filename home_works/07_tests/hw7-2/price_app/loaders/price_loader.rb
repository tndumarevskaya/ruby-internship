# frozen_string_literal: true

require 'csv'
require_relative '../data_models/price'

# Класс PriceLoader загружает цены из CSV файла.
class PriceLoader
  attr_reader :prices

  # Инициализирует загрузчик цен с указанным именем файла.
  # file_name - Имя файла CSV (строка) (по умолчанию: './csv/prices.csv').
  def initialize(file_name = './csv/prices.csv')
    @prices = []
    load_data(file_name)
  end

  # Загружает данные о ценах из указанного файла.
  def load_data(file_name)
    CSV.foreach(file_name) do |row|
      type, price = row.map(&:strip)
      prices << Price.new(type, price)
    end
  end

  # Возвращает цену для указанного типа параметра вм.
  def get_price(type)
    @prices.find { |price| price.type == type }.price
  end
end
