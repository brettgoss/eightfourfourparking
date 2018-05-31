require 'dotenv'
require_relative '../helpers'

Dotenv.load
include Helpers

class Booking
  def initialize
    puts get_items
  end

  def get_items
    return "test"
  end

  def get_slip
  end
end
# Called when run on the command line but not in a require
if __FILE__ == $PROGRAM_NAME
  Booking.new
end