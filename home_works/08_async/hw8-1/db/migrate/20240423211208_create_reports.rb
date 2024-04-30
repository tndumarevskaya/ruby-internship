class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :name
      t.string :body
      t.integer :report_type

      t.timestamps
    end
  end
end
