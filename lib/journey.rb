require_relative 'oystercard'

class Journey

  attr_accessor :start, :journey

  def initialize(start)
    @journeys = []
    @journey = {entry: start , exit: 'end'}
  end

end
