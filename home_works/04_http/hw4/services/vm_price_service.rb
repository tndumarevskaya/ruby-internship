require_relative './price_calculator'

class VmPriceService
  def initialize(prices)
    @price_calculator = PriceCalculator.new(prices)
  end

  def call(params)
    validate_params(params)
    validate_volumes_params(params[:volumes])
    price = @price_calculator.calculate_price(params)
    { price: price }
  end

  private

  def validate_params(params)
    return if params['cpu'] && params['ram'] && params['hdd_type'] && params['hdd_capacity']

    raise ArgumentError, 'Missing required parameters'
  end

  def validate_volumes_params(volumes)
    return if volumes.nil?

    volumes.each do |_, volume_params|
      if volume_params['hdd_capacity'].nil? || volume_params['hdd_type'].nil?
        raise ArgumentError, 'Missing required parameters for volume'
      end
    end
  end
end