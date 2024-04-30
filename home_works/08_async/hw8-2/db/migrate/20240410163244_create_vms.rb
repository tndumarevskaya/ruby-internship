class CreateVms < ActiveRecord::Migration[6.1]
  def change
    create_table :vms do |t|
      t.string :name
      t.string :cpu
      t.string :cost
      
      t.timestamps
    end
  end
end
