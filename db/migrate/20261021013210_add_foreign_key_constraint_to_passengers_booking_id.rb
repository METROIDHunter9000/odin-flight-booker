class AddForeignKeyConstraintToPassengersBookingId < ActiveRecord::Migration[8.1]
  def change
    add_foreign_key :passengers, :bookings 
  end
end
