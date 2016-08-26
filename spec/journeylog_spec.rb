require 'journeylog'

describe JourneyLog do

  let(:journey_obj) {double :journey_obj}

  xit 'stores journeys' do
    expect subject.journeys.to include journey
  end

  it 'receives a journey object and stores it in journeys' do
    subject.log(journey_obj)
    expect(subject.journeys).to include journey_obj
  end




end
