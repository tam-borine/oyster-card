require_relative 'journey'
require_relative 'fare_calc'

class Oystercard

  attr_reader :limit, :fare, :entry_station, :journeys
  attr_accessor :current_journey, :balance

  DEFAULT_LIMIT = 90
  DEFAULT_BALANCE = 0

  def initialize(limit = DEFAULT_LIMIT, balance = DEFAULT_BALANCE)
    @limit = limit
    @balance = balance
    @current_journey = nil
    fail 'Balance cannot be larger than limit' if balance > limit
  end

  def top_up(amount)
    fail 'Balance limit reached' if full? || amount > limit
    @balance += amount
    balance_confirmation
  end

  def touch_in(station)
    fail 'Insufficient funds' if balance < FareCalculator::MINIMUM_FARE   ##############
    fail 'must touch out first' if started?
    @current_journey = Journey.new(station)
    station
  end

  def touch_out(station)
    fail "must touch in first" if !started?
    FareCalculator.new.deduct
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

  def balance_confirmation
    "Your new balance is #{balance}"
  end

end
