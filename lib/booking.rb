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
    res['item']['rate']['slip']
  end

  def post_slip_to_session(slip)
    json_body = JSON.generate({
      "slip": slip
    })
    res = Helpers::post("booking/session", json_body)
    ap res
    res['booking']['session']['id']
  end

  def create_booking_from_session(session_id)
    json_body = JSON.generate({
      "session_id": session_id,
      "form": {
        "customer_name": "#{ENV['CUSTOMER_NAME']}",
        "customer_email": "#{ENV['CUSTOMER_EMAIL']}"
      }
    })
    puts session_id
    res = Helpers::post("booking/create", json_body)
    ap res
  end
end

# Called when run on the command line but not in a require
if __FILE__ == $PROGRAM_NAME
  Booking.new
end