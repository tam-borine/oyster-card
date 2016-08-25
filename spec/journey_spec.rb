require 'journey'

describe Journey do

  subject {described_class.new("station")}


  it 'initializes with a start' do
    expect(Journey.new('start').journey[:entry]).to eq 'start'
  end

  it 'returns true if journey is complete' do
    subject.complete("station")
    expect(subject.completed).to be true
  end

  it 'returns false if journey is incomplete' do
    expect(subject.completed).to be false
  end

      it 'stores a journey' do
        subject.complete("station")
        expect(subject.journeys).to eq [{entry: "station", exit: "station"}]
      end

  xit 'is initially not in a journey' do
    expect(oystercard).not_to be_in_journey
  end

      it 'will remember the entry station' do
        expect(subject.journey[:entry]).to eq "station"
      end

end
