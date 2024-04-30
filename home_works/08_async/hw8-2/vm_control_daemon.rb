require 'bunny'
require './app/services/stop_vm_service.rb'

connection = Bunny.new('amqp://guest:guest@rabbitmq')
connection.start
channel = connection.create_channel
queue = channel.queue('vm.control', auto_delete: true)

begin
  puts 'listening'
  queue.subscribe(block: true) do |_delivery_info, _metadata, payload|
    StopVmService.call(payload)
    exchange = channel.default_exchange
    queue_name = 'vm.status'
    exchange.publish('Message from vm_control', routing_key: queue_name)
  end
  rescue Interrupt => _
    puts 'exiting'
    connection.close
    exit(0)
end

