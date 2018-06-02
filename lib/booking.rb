require 'dotenv'
require 'awesome_print'
require_relative 'helpers'

Dotenv.load
include Helpers

class Booking
  def initialize
    @slip = get_slip
    @session_id = post_slip_to_session(@slip)
    @customer = get_customer_details(ENV['CUSTOMER_CODE'])
    create_booking_from_session(@session_id)
  end

  def get_slip
    res = Helpers::get('item/4?start_date=monday&end_date=monday+4days')
    slip = res['item']['rate']['slip']
    avail = res['item']['rate']['status']

    if slip.nil?
      ap avail
      exit
    else
      ap avail
      return slip
    end
  end

  def post_slip_to_session(slip)
    json_body = JSON.generate({
      "slip": slip
    })
    res = Helpers::post("booking/session", json_body)
    ap res
    res['booking']['session']['id']
  end

  def create_booking_from_session(session_id, customer = {})
    json_body = JSON.generate({
      "session_id": session_id,
      "form": {
        "customer_name": customer['customer_name'],
        "customer_email": customer['customer_email']
      }
    })

    res = Helpers::post("booking/create", json_body)
    ap res
  end

  def get_customer_details(customer_code)
    customer = Helpers::get("customer/#{customer_code}")['customer']
    customer.delete("bookings")
    return customer
  end
end

# Called when run on the command line but not in a require
if __FILE__ == $PROGRAM_NAME
  Booking.new
end