# frozen_string_literal: true

require 'securerandom'

# model to deal with Park logic and database
class Park < ApplicationBaseModel
  before_create :generate_code

  field :plate,       type: String
  field :paid,        type: Boolean, default: false
  field :left,        type: Boolean, default: false
  field :reservation, type: String

  PLATE_REGEX = /\A[a-zA-Z]{3}-[0-9]{4}\Z/
  validates :plate, format: { with: PLATE_REGEX }

  def generate_code
    self.reservation = SecureRandom.alphanumeric
  end

  def self.history(parks)
    return [] if parks.empty?

    parks.map(&:fetch_single_details)
  end

  def fetch_single_details
    single_details
  end

  def fetch_reservation_details
    reservation_details
  end

  private

  def fetch_time
    diff = (DateTime.now - created_at.to_datetime)

    days, hours, minutes, seconds = fetch_periods(diff)

    return "#{seconds} seconds" if minutes.zero?
    return "#{minutes} minutes" if hours.zero?
    return "#{hours} hours" if days.zero?

    "#{days} days"
  end

  def fetch_periods(time_diff)
    [time_diff.to_i,
     (time_diff * 24).to_i,
     (time_diff * 24 * 60).to_i,
     (time_diff * 24 * 60 * 60).to_i]
  end

  def single_details
    { time: fetch_time,
      paid:,
      left:,
      plate:,
      reservation: }
  end

  def reservation_details
    { reservation:,
      plate:,
      entered_at: created_at }
  end
end
