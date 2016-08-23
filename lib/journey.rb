

class Journey

  attr_reader :start, :journey

  def initialize(start)
    @start = start
    @journey = {entry: 'start' , exit: 'end'}
  end

end
