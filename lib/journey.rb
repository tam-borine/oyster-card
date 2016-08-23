require_relative 'oystercard'

class Journey

  attr_accessor :start, :journey

  def initialize
    @start = "start_station"
    @journeys = []
    @journey = {entry: 'startssss' , exit: 'end'}
  end

end
