require_relative 'journey'

class Oystercard

  attr_reader :limit, :fare, :entry_station, :journeys, :current_journey
  attr_accessor :balance

  DEFAULT_LIMIT = 90
  DEFAULT_BALANCE = 0
  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize(limit = DEFAULT_LIMIT, balance = DEFAULT_BALANCE)
    @limit = limit
    @balance = balance
    @current_journey = nil
    fail 'Balance cannot be larger than limit' if full?
  end

  def top_up(amount)
    fail 'Balance limit reached' if (balance + amount) >= limit
    @balance += amount
    balance_confirmation
  end

  def touch_in(station)
    fail 'Insufficient funds' if balance < MINIMUM_FARE
    @balance -= PENALTY_FARE if started?
    @current_journey = Journey.new(station)
    station
  end

  def touch_out(station)
    return @balance -= PENALTY_FARE if !started?
    deduct
    @current_journey.complete(station)
    @current_journey = nil
  end

  private

  attr_reader :balance_confirmation

  def full?
    balance >= limit
  end

  def started?
    @current_journey != nil
  end

  def deduct
    @balance -= MINIMUM_FARE
  end


  def balance_confirmation
    "Your new balance is #{balance}"
  end

end
