require 'dotenv'
require 'awesome_print'
require_relative 'helpers'

Dotenv.load
include Helpers

class Booking
  def initialize
    @slip = get_slip
    @session_id = post_slip_to_session(@slip)
    create_booking_from_session(@session_id)
  end

  def get_slip
    res = Helpers::get('item/4?start_date=monday&end_date=monday+4days')
    JSON.parse(res)['item']['rate']['slip']
  end

  def post_slip_to_session(slip)
    json_body = JSON.generate({
      "slip": slip,
      "form": {
        "customer_name": "Brett Goss",
        "customer_email": "#{ENV['CUSTOMER_EMAIL']}"
      }
    })
    res = Helpers::post("booking/session", json_body)
    ap JSON.parse(res)
  end

  def create_booking_from_session(session)
  end
end
# Called when run on the command line but not in a require
if __FILE__ == $PROGRAM_NAME
  Booking.new
end