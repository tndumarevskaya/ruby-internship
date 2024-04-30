class GrapeApi
  class OrdersApi < Grape::API
    format :json

    namespace :orders do
      desc 'Get all orders'
      get do
        orders = Order.all
        present orders
      end

      route_param :id, type: Integer do
        desc 'Get an order by ID'
        get do
          order = Order.find_by_id(params[:id])
          error!({ message: "Order not found" }, 404) unless order
          present order
        end

        desc 'Delete an order by ID'
        delete do
          order = Order.find_by_id(params[:id])
          error!({ message: "Order not found" }, 404) unless order
          order.destroy
          status 204
        end

        desc 'Update the status of an order'
        params do 
          requires :status, type: String
        end
        put do
          service = UpdateOrderStatusService.new(params[:id], declared(params))
          service.call
        end
      end
    end
  end
end
