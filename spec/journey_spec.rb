require 'journey'

describe Journey do

  subject {described_class.new}

  it 'initializes with a start' do
    expect(Journey.new('start').start).to eq 'start'

  end

  it 'recieves the entry_station from oystercard' do
    card = Oystercard.new
    card.top_up(5)
    card.touch_in('aldgate')
    expect(subject.journey[:entry]).to eq 'aldgate'
  end


end
