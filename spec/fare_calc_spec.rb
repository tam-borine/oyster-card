require 'fare_calc'

describe FareCalculator do

  it 'has a minimum fare' do
    expect(subject.fare).to eq described_class::MINIMUM_FARE
  end

  it 'deducts the minimum fare on touch out' do
    expect { subject.deduct}.to change{subject.balance}.by(-subject.fare)
  end

  it 'deducts the penalty fare on touch in when not touch out' do

    
  end
end
