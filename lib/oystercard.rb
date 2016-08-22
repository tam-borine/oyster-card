class Oystercard

  attr_reader :balance
  LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(money)
    @balance += money
    raise "You can only top up a maximum of £90" if @balance > LIMIT
    @balance
  end

end
