require 'bunny'
require './app/services/stop_vm_service.rb'

connection = Bunny.new('amqp://guest:guest@rabbitmq')
connection.start
channel = connection.create_channel
exchange = channel.default_exchange
queue_name = 'vm.control'
exchange.publish('Message from vm_daemon', routing_key: queue_name)

queue = channel.queue('vm.status', auto_delete: true)
begin
  puts 'listening'
  queue.subscribe(block: true) do |_delivery_info, _metadata, payload|
    puts "Message from vm.control "
    puts 'exiting'
    connection.close
    exit(0)
  end
end