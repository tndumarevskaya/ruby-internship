# Подключение библиотеки Bunny для работы с RabbitMQ
require 'bunny'
# Подключение сервиса ChangeOrderStatusService для обработки сообщений
require './app/services/change_order_status_service.rb'

# Установка соединения с RabbitMQ
connection = Bunny.new('amqp://guest:guest@rabbitmq')
connection.start
# Создание канала для обмена сообщениями
channel = connection.create_channel
# Определение очереди для получения сообщений о статусе заказа
queue = channel.queue('order.status', auto_delete: true)

begin
  # Вывод сообщения о начале прослушивания очереди
  puts 'listening'
  # Прослушивание очереди на наличие новых сообщений
  queue.subscribe(block: true) do |_delivery_info, _metadata, payload|
    # Вызов сервиса для обновления статуса заказа на основе полученной полезной нагрузки
    ChangeOrderStatusService.call(payload)
  end
# Обработка прерывания (Ctrl+C)
rescue Interrupt => _
  # Вывод сообщения о завершении работы и закрытие соединения с RabbitMQ
  puts 'exiting'
  connection.close
  exit(0)
end
