require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) {{entry_station: entry_station, exit_station: exit_station}}

  describe '#initialize' do
    it 'instantiates with a balance of 0' do
      oystercard = Oystercard.new
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


  end

    before do
      oystercard.top_up(10)
    end

    describe '#top_up' do

      it 'confirms new balance after top-up' do
        msg = "Your new balance is 10"
        expect(oystercard.top_up(0)).to eq msg
      end

      it 'updates the balance' do
        expect(oystercard.balance).to eq 10
      end

      it 'raises error if limit reached' do
        oystercard.top_up(90)
        msg = 'Balance limit reached'
        expect {oystercard.top_up(1)}.to raise_error msg
      end
    end

    describe '#touch_in' do

      it 'will not touch in if insufficient funds' do
        oystercard = Oystercard.new(90,0)
        msg = 'Insufficient funds'
        expect { oystercard.touch_in(entry_station) }.to raise_error msg
      end

      it "returns the entry station with string passed in" do
        expect(oystercard.touch_in("bank")).to eq "bank"
      end

      it "updates the current journey attribute when touch in" do
        oystercard.touch_in("station")
        expect(oystercard.current_journey).to_not eq nil
      end

      it 'does not allow touch in if no touch out' do
        oystercard.touch_in("station1")
        expect{oystercard.touch_in("station2")}.to raise_error "must touch out first"
      end

    end

    describe '#touch_out' do

      it 'does not allow touch out if not touched in' do
        expect{oystercard.touch_out("station")}.to raise_error "must touch in first"
      end

      before do
        oystercard.touch_in("station")
        oystercard.touch_out("station")
      end
      it 'will forget journey after touch out' do
        expect(oystercard.current_journey).to eq nil
      end

    end
end
