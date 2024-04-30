# frozen_string_literal: true

require_relative './price_calculator'

# Сервис VmPriceService предоставляет функционал для расчета стоимости виртуальной машины.
class VmPriceService
  def initialize
    @price_calculator = PriceCalculator.new
  end

  # Выполняет расчет стоимости виртуальной машины на основе переданных параметров.
  #
  # params - Хэш параметров для расчета стоимости виртуальной машины.
  #
  # Возвращает хэш с ключом :price, содержащим рассчитанную стоимость.
  def call(params)
    validate_params(params)
    validate_volumes_params(params[:volumes])
    price = @price_calculator.calculate_price(params)
    { price: price }
  end

  private

  # Проверяет наличие обязательных параметров.
  def validate_params(params)
    return if params['cpu'] && params['ram'] && params['hdd_type'] && params['hdd_capacity']

    raise ArgumentError, 'Missing required parameters'
  end

  # Проверяет наличие обязательных параметров для каждого дополнительного диска.
  def validate_volumes_params(volumes)
    return if volumes.nil?

    volumes.each do |_, volume_params|
      if volume_params['hdd_capacity'].nil? || volume_params['hdd_type'].nil?
        raise ArgumentError, 'Missing required parameters for volume'
      end
    end
  end
end
