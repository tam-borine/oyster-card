require 'journey'

describe Journey do

  subject {described_class.new("startstation", 1)}


  it 'initializes with a start' do
    expect(Journey.new('start', 1).journey[:entry]).to eq ['start', 1]
  end

  it 'returns true if journey is complete' do
    subject.complete("station", 1)
    expect(subject.completed).to be true
  end

  it 'returns false if journey is incomplete' do
    expect(subject.completed).to be false
  end

  it 'stores a journey' do
    subject.complete("stationexit", 1)
    expect(subject.journey).to eq({entry: ["startstation", 1] , exit: ["stationexit", 1]})
  end

  it 'will remember the entry station' do
    expect(subject.journey[:entry]).to eq ["startstation", 1]
  end

end
