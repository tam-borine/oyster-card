class Oystercard

  attr_reader :balance, :entry_station

  LIMIT = 90
  MIN = 1

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(money)
    @balance += money
    raise "You can only top up a maximum of £90" if @balance > LIMIT
    @balance
  end

  def touch_in(station="okfam")
    fail "not enough money, please top up" if @balance < MIN
    @in_transit = true
    @entry_station = station
  end

  def touch_out
    @balance -= MIN
    @in_transit = false
    @entry_station = nil
  end

  def in_journey?
    @entry_station
  end

end
