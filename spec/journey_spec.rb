require 'journey'

describe Journey do

  subject {described_class.new("bank")}
  let(:oystercard) {double(:oystercard, :top_up => 4)}

  it 'initializes with a start' do
    expect(Journey.new('start').journey[:entry]).to eq 'start'
  end


      xit 'will deduct fare amount from card balance' do
        oystercard.top_up(5)
        oystercard.touch_in(entry_station)
        oystercard.touch_out(exit_station)
        expect(oystercard.balance).to eq 4
      end

      xit 'will forget journey after touch out' do
        oystercard.top_up(4)
        oystercard.touch_in(entry_station)
        oystercard.touch_out(exit_station)
        expect(oystercard.entry_station).to eq nil
      end

      xit 'stores a journey' do
        oystercard.top_up(5)
        oystercard.touch_in(entry_station)
        oystercard.touch_out(exit_station)
        expect(oystercard.journeys).to include journey
      end

  xit 'is initially not in a journey' do
    expect(oystercard).not_to be_in_journey
  end

      xit 'will be aware of journey status' do
      oystercard.top_up(1)
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
      end

          xit 'will be aware of not journey status' do
          oystercard.top_up(1)
          oystercard.touch_in(entry_station)
          oystercard.touch_out(exit_station)
          expect(oystercard).not_to be_in_journey
          end


      it 'will remember the entry station after touch in' do
        expect(subject.journey[:entry]).to eq "bank"
      end

end
