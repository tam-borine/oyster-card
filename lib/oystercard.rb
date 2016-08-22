class Oystercard

  attr_reader :balance, :limit

  DEFAULT_LIMIT = 90
  DEFAULT_BALANCE = 0

  def initialize(limit = DEFAULT_LIMIT, balance = DEFAULT_BALANCE)
    @limit = limit
    @balance = balance
    fail 'Balance cannot be larger than limit' if balance > limit
  end

  def top_up(amount)
    fail 'Balance limit reached' if full? || amount > 90
    @balance += amount
    top_up_confirmation
  end

  private

  def full?
    balance >= 90
  end

  def top_up_confirmation
    "Your new balance is #{balance}"
  end


end
