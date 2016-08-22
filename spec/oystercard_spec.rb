require 'oystercard'

describe Oystercard do

#let(:balance){ balance = 30}

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

   it "changes the in transit variable to true" do
     subject.top_up(30)
     subject.touch_in
     expect(subject).to be_in_journey
   end

   it "changes the in transit variable to false" do
     subject.touch_out
     expect(subject).not_to be_in_journey
   end

   it "requires a minimum balance of 1 before touch in " do
     allow(subject).to receive(:balance) {0}
     expect{subject.touch_in}.to raise_error "not enough money, please top up"
   end

   it "should reduce the balance by the minimum fare" do
     subject.top_up(30)
     subject.touch_in
     expect{subject.touch_out}.to change{subject.balance}.by(-Oystercard::MIN)
   end

   it "remembers the entry station after touch in" do
     subject.top_up(30)
     subject.touch_in("hammersmith")
     expect(subject.in_journey?).to eq "hammersmith"
   end

   it "remembers the entry station after touch in" do
     expect(subject.in_journey?).to eq nil
   end

end
