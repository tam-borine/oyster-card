require 'journey'
require 'oystercard'

describe Journey do

  subject {described_class.new 'start'}

  it 'initializes with a start' do
    expect(Journey.new('start').start).to eq 'start'

  end

  it 'recieves the entry_station from oystercard' do
    card = Oystercard.new
    card.top_up(5)
    card.touch_in('test')
    expect(subject.journey[:entry]).to eq 'test'
  end
end
