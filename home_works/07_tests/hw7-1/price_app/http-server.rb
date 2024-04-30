require 'sinatra'
require_relative './services/vm_price_service.rb'

set :bind, '0.0.0.0'
set :port, 5678

get '/vm-price' do
  begin
    service = VmPriceService.new
    result = service.call(params)
    "#{result[:price]}"
  rescue ArgumentError => e
    status 400
    e.message
  end
end