require 'net/http'
require 'json'

class OrderService

  def self.check_order(check_params, session)
    possible_orders = fetch_possible_orders

    unless check_possible_orders(check_params, possible_orders)
      return { result: false, message: 'Параметры не совпадают с возможными заказами.', status: :not_acceptable}
    end
  
    puts check_possible_orders(check_params, possible_orders)
    result = get_vm_price(check_params[:cpu], check_params[:ram], check_params[:hdd_type], check_params[:hdd_capacity]).to_i
    balance = session[:balance]
  
    unless enough_balance?(result, balance)
      return { result: false, message: 'Недостаточно средств на балансе.', status: :not_acceptable }
    end
  
    balance_after_transaction = balance - result
    session[:balance] = balance_after_transaction 
    { result: true, total: result, balance: balance, balance_after_transaction: balance_after_transaction, status: :ok}
  rescue URI::Error, JSON::ParserError, Net::HTTPError => e
    { result: false, message: e.message, status: :service_unavailable }
  end


  private

  # Получает возможные конфигурации
  def self.fetch_possible_orders
    uri = URI('http://possible_orders.srv.w55.ru')
    JSON.parse(Net::HTTP.get(uri))['specs']
  end

  # Получает цену виртуальной машиныx с переданными параметрами
  def self.get_vm_price(cpu, ram, hdd_type, hdd_capacity)
    uri = URI('http://host.docker.internal:8080/vm-price')
    data = {
      cpu: cpu,
      ram: ram,
      hdd_type: hdd_type,
      hdd_capacity: hdd_capacity
    }
    uri.query = URI.encode_www_form(data)
    response = Net::HTTP.get_response(uri)
    response.body if response.is_a?(Net::HTTPSuccess)
  end

  # Проверяет возможные заказы
  def self.check_possible_orders(check_params, possible_orders)
    possible_orders.any? do |possible_order|
      possible_order['os'].include?(check_params['os']) &&
      possible_order['cpu'].include?(check_params['cpu'].to_i) &&
      possible_order['ram'].include?(check_params['ram'].to_i) &&
      possible_order['hdd_type'].include?(check_params['hdd_type']) &&
      possible_order['hdd_capacity'][check_params['hdd_type']]['from'] <= check_params['hdd_capacity'].to_i &&
      possible_order['hdd_capacity'][check_params['hdd_type']]['to'] >= check_params['hdd_capacity'].to_i
    end
  end

  # Проверяет, достаточно ли средств на балансе для совершения покупки
  def self.enough_balance?(result, balance)
    balance >= result
  end

end
