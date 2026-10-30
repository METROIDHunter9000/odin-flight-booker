class PassengerMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.passenger_mailer.flight_booked_email.subject
  #
  def flight_booked_email
    @passenger = params[:passenger]
    mail to: @passenger.email
  end
end
