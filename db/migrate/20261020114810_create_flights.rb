class CreateFlights < ActiveRecord::Migration[8.1]
  def change
    create_table :flights do |t|
      t.datetime :departure, null: false
      t.datetime :arrival, null: false
      t.belongs_to :origin_airport, null: false, foreign_key: { to_table: :airports }
      t.belongs_to :destination_airport, null: false, foreign_key: { to_table: :airports }

      t.timestamps
    end
  end
end
