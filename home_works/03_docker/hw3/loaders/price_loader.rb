require "csv"
require_relative '../classes/price'

class PriceLoader

  attr_reader :prices

  def initialize(file_name = "./csv/prices.csv")
    @prices = []
    load_data(file_name)
  end

  def load_data(file_name)
    CSV.foreach(file_name) do |row|
      type, price = row.map(&:strip)
      prices << Price.new(type, price)
    end
  end

  def get_price(type)
    @prices.find { |price| price.type == type}.price
  end
end