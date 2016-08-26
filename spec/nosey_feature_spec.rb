require 'oystercard'
require 'journeylog'

describe 'Nosey journey' do

  subject{Oystercard.new}

  before do
    subject.top_up(10)
  end

  it 'wants to check current balance' do
    expect(subject.balance).to eq 10
  end

  it 'wants to see journey history, once journeys have been completed' do
    pending 'touch out nil-ifies current journey so hard to view history'
    subject.touch_in('bank',1)
    expect{subject.touch_out('hammersmith', 2)}.to
    expect(subject.journeylog.journeys).to include ({entry: ['bank', 1], exit: ['hammersmith', 2]})
  end
end
