# frozen_string_literal: true

require_relative '../loaders/price_loader'

# Класс PriceCalculator вычисляет общую стоимость заказа на основе переданных параметров.
class PriceCalculator
  def initialize
    @prices = PriceLoader.new
  end

  # Вычисляет общую стоимость заказа на основе переданных параметров.
  #
  # params - Хэш параметров заказа.
  #          :cpu         - Количество CPU (целое число).
  #          :ram         - Объем RAM (целое число).
  #          :hdd_type    - Тип HDD (строка).
  #          :hdd_capacity - Объем HDD (целое число).
  #          :volumes     - Дополнительные тома (необязательно).
  #
  # Возвращает общую стоимость заказа (целое число).
  def calculate_price(params)
    price = calculate_base_price(params)
    price += calculate_additional_volumes_price(params) if params[:volumes]
    price
  end

  private

  # Вычисляет базовую стоимость заказа на основе основных компонентов.
  def calculate_base_price(params)
    cpu = params['cpu'].to_i
    ram = params['ram'].to_i
    hdd_type = params['hdd_type']
    hdd_capacity = params['hdd_capacity'].to_i

    cpu * @prices.get_price('cpu') + ram * @prices.get_price('ram') + hdd_capacity * @prices.get_price(hdd_type)
  end

  # Вычисляет стоимость дополнительных дисков (если присутствуют).
  def calculate_additional_volumes_price(params)
    params[:volumes].values.sum do |volume_params|
      volume_capacity = volume_params['hdd_capacity'].to_i
      volume_type = volume_params['hdd_type']
      volume_capacity * @prices.get_price(volume_type)
    end
  end
end
