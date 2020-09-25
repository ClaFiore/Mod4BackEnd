class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :table_id
      t.datetime :timeslot
      t.integer :duration
      t.integer :party

      t.timestamps
    end
  end
end
