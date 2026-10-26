class Airport < ApplicationRecord
  validates :code, presence: true, length: {maximum: 3, minimum: 3}
  has_many :inbound_flights, class_name: "Flight", foreign_key: :destination_airport_id
  has_many :outbound_flightrs, class_name: "Flight", foreign_key: :origin_airport_id
end
