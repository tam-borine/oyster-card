require 'fare_calc'

describe FareCalculator do

  it 'has a minimum fare' do
    expect(subject.fare).to eq described_class::MINIMUM_FARE
  end

end
