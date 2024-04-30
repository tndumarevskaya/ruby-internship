# frozen_string_literal: true

require 'sinatra'
require_relative './services/vm_price_service'

set :bind, '0.0.0.0'
set :port, 5678

get '/vm-price' do
  service = VmPriceService.new
  result = service.call(params)
  (result[:price]).to_s
rescue ArgumentError => e
  status 400
  e.message
end
