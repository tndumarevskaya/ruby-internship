class CreateHdds < ActiveRecord::Migration[6.1]
  def change
    create_table :hdds do |t|
      t.string :hdd_type
      t.string :size

      t.timestamps
    end
  end
end
