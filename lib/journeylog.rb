class JourneyLog

  attr_reader :journeys

  def initialize
    @journeys = []
  end

  def log(current_journey)
    @journeys << current_journey
  end

end
