require 'oystercard.rb'

describe Oystercard do

  it 'should initialize with a balance' do
    expect(subject.balance).to eq 0
  end

end
