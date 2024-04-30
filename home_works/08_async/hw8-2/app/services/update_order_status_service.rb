class UpdateOrderStatusService
  def initialize(order_id, status_params)
    @order_id = order_id
    @status_params = status_params
  end

  def call
    order = find_order
    return unless order

    publish_status_update
    order
  end

  private

  def find_order
    Order.find_by_id(@order_id)
  end

  def publish_status_update
    connection = Bunny.new('amqp://guest:guest@rabbitmq')
    connection.start
    channel = connection.create_channel
    exchange = channel.default_exchange
    queue_name = 'order.status'
    exchange.publish(@status_params.to_json, routing_key: queue_name)
    connection.close
  end
end
