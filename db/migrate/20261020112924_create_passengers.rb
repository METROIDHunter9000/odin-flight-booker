class CreatePassengers < ActiveRecord::Migration[8.1]
  def change
    create_table :passengers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.belongs_to :booking, null: false

      t.timestamps
    end
  end
end
