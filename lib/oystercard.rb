require_relative 'journey'

class Oystercard

  attr_reader :limit, :fare, :entry_station, :journeys, :current_journey, :balance

  DEFAULT_LIMIT = 90
  DEFAULT_BALANCE = 0
  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize(limit = DEFAULT_LIMIT, balance = DEFAULT_BALANCE)
    @limit = limit
    @balance = balance
    @current_journey = nil
    @journeylog = JourneyLog.new
    fail 'Balance cannot be larger than limit' if full?
  end

  def top_up(amount)
    fail 'Balance limit reached' if (balance + amount) >= limit
    @balance += amount
    balance_confirmation
  end

  def touch_in(station,zone)
    fail 'Insufficient funds' if balance < MINIMUM_FARE
    @balance -= PENALTY_FARE if started?
    @current_journey = Journey.new(station, zone)
  end

  def touch_out(station, zone)
    return @balance -= PENALTY_FARE if !started?
    @current_journey.complete(station, zone)
    deduct
    @journeylog.log(@current_journey)
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
    zone_difference = @current_journey.journey[:entry][1] - @current_journey.journey[:exit][1]
    @balance -= (MINIMUM_FARE + zone_difference.abs)
  end


  def balance_confirmation
    "Your new balance is #{balance}"
  end

end
