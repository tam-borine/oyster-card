require 'oystercard'

describe Oystercard do

subject{described_class.new}

  it 'A user can top up their Oystercard and balance updates' do
    expect{subject.top_up(20)}.to change{subject.balance}.by 20
  end

  it 'User completes a legitimate journey and the correct fare is deducted' do
    subject.top_up(30)
    subject.touch_in("bank", 4)
    expect{subject.touch_out("aldgate",2)}.to change{subject.balance}.by -3
  end


end
