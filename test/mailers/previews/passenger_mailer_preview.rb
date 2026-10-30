# Preview all emails at http://localhost:3000/rails/mailers/passenger_mailer
class PassengerMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/passenger_mailer/new
  def new
    PassengerMailer.new
  end
end
