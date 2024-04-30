class CreateJoinTableNetworksOrders < ActiveRecord::Migration[6.1]
  def change
    create_join_table :networks, :orders do |t|
      # t.index [:network_id, :order_id]
      # t.index [:order_id, :network_id]
    end
  end
end
