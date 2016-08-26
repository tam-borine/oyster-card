require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

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
        msg = 'Balance limit reached'
        expect {oystercard.top_up(91)}.to raise_error msg
      end
    end

    describe '#touch_in' do

      before do
        oystercard.touch_in("entrystation", 3)
      end

      it 'will not touch in if insufficient funds' do
        oystercard = Oystercard.new(90,0)
        msg = 'Insufficient funds'
        expect { oystercard.touch_in("station", 3)}.to raise_error msg
      end

      it "updates the current journey attribute when touch in" do
        expect(oystercard.current_journey).to_not eq nil
      end
    end

      it 'will forget journey after touch out' do
        oystercard.touch_in("station", 3)
        oystercard.touch_out("station", 3)
        expect(oystercard.current_journey).to eq nil
      end


    context 'about the zone fare calculation' do

      it 'charges minimum fare when entry and exit station are in the same zone' do
        oystercard.touch_in("entrystation", 3)
        expect{oystercard.touch_out("exitstation", 3)}.to change {oystercard.balance}.by -described_class::MINIMUM_FARE
      end

      it 'charges zone difference + min fare when entry and exit stations are in different zones' do
        oystercard.touch_in("entrystation", 3)
        expect{oystercard.touch_out("exitstation", 5)}.to change {oystercard.balance}.by -(described_class::MINIMUM_FARE+2)
      end

    end

    context 'about penalities' do

      it 'gives a penalty when touching out withouth previously touching in' do
      expect{oystercard.touch_out('station', 3)}.to change {oystercard.balance}.by -described_class::PENALTY_FARE
      end

      it 'gives a penalty when touching in without previously touching out' do
        oystercard.touch_in('somestation',3)
        expect{oystercard.touch_in('station',3)}.to change {oystercard.balance}.by -described_class::PENALTY_FARE
      end
    end

end
