class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :tables do |t|
      t.integer :restaurant_id
      t.integer :seats

      t.timestamps
    end
  end
end
