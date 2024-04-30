require_relative '../loaders/price_loader.rb'

class PriceCalculator
  def initialize
    @prices = PriceLoader.new
  end

  def calculate_price(params)
    price = calculate_base_price(params)
    price += calculate_additional_volumes_price(params) if params[:volumes]
    price
  end

  private

  def calculate_base_price(params)
    cpu = params['cpu'].to_i
    ram = params['ram'].to_i
    hdd_type = params['hdd_type']
    hdd_capacity = params['hdd_capacity'].to_i

    cpu * @prices.get_price("cpu") + ram * @prices.get_price("ram") + hdd_capacity * @prices.get_price(hdd_type)
  end

  def calculate_additional_volumes_price(params)
    params[:volumes].values.sum do |volume_params|
      volume_capacity = volume_params['hdd_capacity'].to_i
      volume_type = volume_params['hdd_type']
      volume_capacity * @prices.get_price(volume_type)
    end
  end
end