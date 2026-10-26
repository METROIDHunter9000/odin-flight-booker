class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.belongs_to :flight, null: false, foreign_key: true

      t.timestamps
    end
  end
end
