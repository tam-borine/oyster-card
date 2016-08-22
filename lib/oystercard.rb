class Oystercard

  attr_reader :balance, :entry_station, :journeys, :journey

  LIMIT = 90
  MIN = 1

  def initialize
    @balance = 0
    @in_transit = false
    @journeys = []
    @journey = {:entry => :station, :exit => :station}
  end

  def top_up(money)
    @balance += money
    raise "You can only top up a maximum of £90" if @balance > LIMIT
    @balance
  end

  def touch_in(station="okfam")
    fail "Not enough money, please top up" if @balance < MIN
    @in_transit = true
    @journey[:entry] = station
  end

  def touch_out(exit_station="oxfam")
    @balance -= MIN
    @in_transit = false
    @journey[:exit] = exit_station
    @journeys << @journey
  end

  def in_journey?
    @in_transit
  end

end
