require 'Oystercard'

feature Oystercard do

subject{described_class.new}

  scenario 'A user can top up their Oystercard and balance updates' do
    expect{subject.top_up(20)}.to change{subject.balance}.by 20
  end

end
