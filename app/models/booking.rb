class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passengers
  validates_associated :passengers

  # validates each property given to it (e.g. ":passengers")
  # does not perform a validation on each passenger
  validates_each :passengers do |booking, attr, value|
    booking.errors.add(attr, "- please enter at least one passenger to book this flight") if value.length < 1
  end

  accepts_nested_attributes_for :passengers, reject_if: ->(attributes) { attributes[:email].blank? && attributes[:name].blank? }
end
