require_relative 'oystercard'

class Journey

  attr_reader :journey, :completed

  def initialize(name, zone)
    @journey = {entry: [name, zone] , exit: [nil, zone]}
    @completed = false
  end

  def complete(station, zone)
  @journey[:exit][0] = station
  @journey[:exit][1] = zone
  @completed = true
  end

end
