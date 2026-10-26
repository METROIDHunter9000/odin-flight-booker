class Flight < ApplicationRecord
  belongs_to :origin, foreign_key: "origin_airport_id", class_name: "Airport"
  belongs_to :destination, foreign_key: "destination_airport_id", class_name: "Airport"
  has_many :bookings
  has_many :passengers, through: :bookings

  validates :departure, presence: true
  validates :arrival, presence: true

  scope :with_max_passengers, ->(count) do
    # The SQL query we need looks like this:
    # SELECT flights.id, COUNT(DISTINCT passengers.id) as num_passengers FROM flights LEFT OUTER JOIN bookings ON flights.id = bookings.flight_id LEFT OUTER JOIN passengers ON bookings.id = passengers.booking_id GROUP BY flights.id;
    left_outer_joins(bookings: [ :passengers ])
      .group("flights.id")
      .having("COUNT(DISTINCT passengers.id) <= ?", count)
  end

  def summary
    "Flight from #{self.origin.code} to #{self.destination.code} on #{self.departure} - #{self.passengers.length} passengers"
  end
end
