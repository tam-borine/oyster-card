require 'JourneyLog'

describe JourneyLog do

  subject(:journeylog) {described_class.new}
  let(:entry_station){double :entry_station}
  let(:exit_station){double :exit_station}


  it 'starts a new journey' do
    expect(journeylog.start(entry_station)).to eq entry_station
  end

  it 'starts a journey with an entry station' do

  end

  it 'finishes a journey with an exit station' do

  end

  it 'can show journey history' do


  end


end
