require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) {{entry_station: entry_station, exit_station: exit_station}}


  describe '#initialize' do
    it 'instantiates with a balance of 0' do
      expect(oystercard.balance).to eq described_class::DEFAULT_BALANCE
    end

    it 'has a default limit' do
      expect(oystercard.limit).to eq described_class::DEFAULT_LIMIT
    end

    it 'sets a given limit' do
      oystercard = Oystercard.new 100
      expect(oystercard.limit).to eq 100
    end

    it 'sets a given balance' do
      oystercard = Oystercard.new 100, 50
      expect(oystercard.balance).to eq 50
    end

    it 'raises an error when instantiated balance is larger than limit' do
      msg = 'Balance cannot be larger than limit'
      expect {Oystercard.new 50, 100}.to raise_error msg
    end

    it 'is initially not in a journey' do
      expect(oystercard).not_to be_in_journey
    end

    it 'has a minimum fare' do
      expect(oystercard.fare).to eq described_class::MINIMUM_FARE
    end

    it 'has an empty list of journeys by default' do
      expect(oystercard.journeys).to be_empty
    end

  end

  describe '#top_up' do

    it 'confirms new balance after top-up' do
      msg = "Your new balance is 10"
      expect(oystercard.top_up(10)).to eq msg
    end

    it 'updates the balance' do
      oystercard.top_up(10)
      expect(oystercard.balance).to eq 10
    end

    it 'raises error if limit reached' do
      oystercard.top_up(90)
      msg = 'Balance limit reached'
      expect {oystercard.top_up(1)}.to raise_error msg
    end
  end

  describe '#touch_in' do

    it 'will be aware of journey status' do
    oystercard.top_up(1)
    oystercard.touch_in(entry_station)
    expect(oystercard).to be_in_journey
    end

    it 'will not touch in if insufficient funds' do
      msg = 'Insufficient funds'
      expect { oystercard.touch_in(entry_station) }.to raise_error msg
    end

    it 'will remember the entry station after touch in' do
      oystercard.top_up(4)
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq entry_station
    end


  describe '#touch_out' do

    it 'will be aware of journey status' do
    oystercard.top_up(1)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard).not_to be_in_journey
    end

    it 'will deduct fare amount from card balance' do
      oystercard.top_up(5)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.balance).to eq 4
    end

    it 'will forget the entry station after touch out' do
      oystercard.top_up(4)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.entry_station).to eq nil
    end

    it 'stores a journey' do
      oystercard.top_up(5)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys).to include journey
    end

    context 'when not in journey'
    it 'does not allow touch out'
    end
  end
end
