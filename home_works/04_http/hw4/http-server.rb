require 'sinatra'
require_relative './services/vm_price_service.rb'
require_relative './loaders/price_loader.rb'

set :bind, '0.0.0.0'
set :port, 5678

prices = PriceLoader.new

get '/vm-price' do
  begin
    service = VmPriceService.new(prices)
    result = service.call(params)
    "#{result[:price]}"
  rescue ArgumentError => e
    status 400
    e.message
  end
end