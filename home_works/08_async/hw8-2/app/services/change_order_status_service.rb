require 'json'
require_relative '../../config/environment.rb'

class ChangeOrderStatusService
  # Метод для обновления статуса заказа
  def self.call(payload)
    puts 'Starting update status of order'
    
    # Прогресс-индикатор для имитации обновления статуса
    10.times do
      putc '.'
      sleep 1
    end
    puts

    # Разбор JSON-полезной нагрузки
    payload = JSON.parse(payload)
    # Поиск заказа по ID в базе данных
    order = Order.find_by_id(payload["id"])
    # Вывод текущего статуса заказа
    puts "The status was #{order[:status]}"
    # Вывод нового статуса заказа
    puts "Changed on #{payload["status"]}"

    # Обновление статуса заказа в базе данных
    order.update(status: payload["status"])
    
    # В случае ошибки возвращается код 400 с сообщением "Mistake"
    error!({ message: "Mistake" }, 400) unless 200
  end
end
