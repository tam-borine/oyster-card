class Oystercard

  attr_reader :balance

  LIMIT = 90
  MIN = 1

  def initialize
    @balance = 0
    @in_transit = false
  end

  def top_up(money)
    @balance += money
    raise "You can only top up a maximum of £90" if @balance > LIMIT
    @balance
  end

  def touch_in
    fail "not enough money, please top up" if @balance < MIN
    @in_transit = true
  end

  def touch_out
    @balance -= MIN
    @in_transit = false
  end

  def in_journey?
    @in_transit
  end

end
