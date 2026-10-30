class BookingsController < ApplicationController
  def new
    begin
      params.expect(:flight_id)
      @flight = Flight.find(params[:flight_id])

      @booking = Booking.new
      2.times { @booking.passengers.build }
      @passengers = @booking.passengers
    rescue ActionController::ParameterMissing
      flash[:error] = "No flight specified"
      @flight = nil
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "No flight found by ID #{params[:flight_id]}"
      @flight = nil
    end
  end

  def create
    b = Booking.new(booking_params)

    if b.save
      b.passengers.each { |p| PassengerMailer.with(passenger: p).flight_booked_email.deliver_later }
      flash.notice = "Successfully booked flight from #{b.flight.origin.code} to #{b.flight.destination.code} for #{b.passengers.length} #{b.passengers.length > 1 ? 'people' : 'person'}!"
      redirect_to flights_path
    else
      msg = "Error booking flight"
      b.errors.full_messages.each { |e| msg += "\n#{e}" }
      # Keep the user on the booking page so they can try again without pressing the "back" button
      # Ideally, this kind of thing would be done with JavaScript by highlighting individual fields
      # and providing error messages without reloading the entire page
      flash[:error] = msg
      redirect_to "#{new_booking_path}?flight_id=#{b.flight_id}"
    end
  end

  private
  def booking_params
    params.expect(booking: [ :flight_id, passengers_attributes: [ [ :id, :name, :email ] ] ])
  end
end
