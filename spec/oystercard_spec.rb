require 'oystercard'

describe Oystercard do



  it 'should initialize with a balance' do
    expect(subject.balance).to eq 0
  end

  it "should top up balance by 76" do
    money = 76
    expect{subject.top_up(money)}.to change{subject.balance}.by(money)
   end

   it "should raise an error if balance is more than 90" do
     expect{subject.top_up(Oystercard::LIMIT + 1)}.to raise_error("You can only top up a maximum of £90")
   end

   it "deducts the specified amount from balance" do
     money = 88
     expect{subject.deduct(money)}.to change{subject.balance}.by(-money)

   end

end
