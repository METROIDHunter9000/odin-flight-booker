class FlightsController < ApplicationController
  def index
    @flights = Flight.all

    origin_airport_id = params.dig(:origin_airport_id)
    if origin_airport_id && origin_airport_id != "any"
      @flights = @flights.where(origin: origin_airport_id)
    end

    destination_airport_id = params.dig(:destination_airport_id)
    if destination_airport_id && destination_airport_id != "any"
      @flights = @flights.where(destination: destination_airport_id)
    end

    departure = params.dig(:departure)
    if departure && departure != "any"
      bound_inner = departure
      bound_outer = (departure.to_time + 1.days).strftime("%Y-%m-%d")
      @flights = @flights.where("departure between ? and ?", bound_inner, bound_outer)
    end

    max_passengers = params.dig(:max_passengers)
    if max_passengers and !max_passengers.empty?
      @flights = @flights.with_max_passengers(max_passengers.to_i)
    end

    @flights = @flights.order(:departure)

    @airport_options = Airport.order(:code).map { |a| [ a.code, a.id ] }
    @airport_options.insert(0, [ "Any", "any" ])

    @departure_options = Flight
      .order(:departure)
      .map { |f|
        date = f.departure.strftime("%Y-%m-%d")
        [ date, date ]
      } .uniq
    @departure_options.insert(0, [ "Any", "any" ])
  end

  def show
    @flight = Flight.find(params[:id])
  end
end
