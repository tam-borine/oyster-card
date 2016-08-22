require_relative 'station'
class Oystercard

  attr_reader :balance, :entry_station, :journeys, :journey, :location

  LIMIT = 90
  MIN = 1

  def initialize
    @balance = 0
    @in_transit = false
    @journeys = []
    @location = Station.new("hamdfsdf", "5")
    @journey = {:entry => :location, :exit => :location}
  end

  def top_up(money)
    @balance += money
    raise "You can only top up a maximum of £90" if @balance > LIMIT
    @balance
  end

  def touch_in(location=@location)
    fail "Not enough money, please top up" if @balance < MIN
    @in_transit = true
    @journey[:entry] = location
  end

  def touch_out(exit_station="oxfam")
    @balance -= MIN
    @in_transit = false
    @journey[:exit] = exit_station
    @journeys << @journey
    @location = exit_station
  end

  def in_journey?
    @in_transit
  end

end
