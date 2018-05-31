require 'dotenv'
Dotenv.load

class Booking
  def get_items
  end

  def get_slip
  end
end
# Called when run on the command line but not in a require
if __FILE__ == $PROGRAM_NAME
  Booking.new.get_items
end