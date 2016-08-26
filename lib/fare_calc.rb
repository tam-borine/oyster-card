require_relative 'oystercard'

class FareCalculator

MINIMUM_FARE = 1

  attr_reader :fare
  attr_accessor :balance

  def initialize(oc = Oystercard)
    @fare = MINIMUM_FARE
    @balance = oc.balance
  end

  def deduct
    @balance -= @fare
  end

end
