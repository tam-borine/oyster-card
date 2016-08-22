require 'oystercard'

describe Oystercard do

  it 'should initialize with a balance' do
    expect(subject.balance).to eq 0
  end

  it "should increment the count by 2" do
    money = 76
    expect{subject.top_up(money)}.to change{subject.balance}.by(money)
   end

end
