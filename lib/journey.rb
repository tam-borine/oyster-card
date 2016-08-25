require_relative 'oystercard'

class Journey

  attr_reader :journey, :completed, :journeys

  def initialize(start )
    @journey = {entry: start , exit: nil}
    @completed = false
  end

  def complete(station)
  @journey[:exit] = station
  @completed = true
  end

end
