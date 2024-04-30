class AddRamToVm < ActiveRecord::Migration[6.1]
  def change
    add_column :vms, :ram, :integer
  end
end
