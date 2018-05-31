require 'dotenv'
require 'awesome_print'
require_relative 'helpers'

Dotenv.load
include Helpers

class Booking
  def initialize
    get_slip
    ap post_slip_to_session(@slip)
    create_booking_from_session
  end

  def get_slip
    res = Helpers::get('item/19?start_date=monday&end_date=monday+4days')
    @slip = JSON.parse(res)['item']['rate']['slip']
  end

  def post_slip_to_session(slip)
    return slip
  end

  def create_booking_from_session(session)
  end
end
# Called when run on the command line but not in a require
if __FILE__ == $PROGRAM_NAME
  Booking.new
end