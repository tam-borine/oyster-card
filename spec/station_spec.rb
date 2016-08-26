require 'station'

describe Station do

  it "inits zone" do
    subject = Station.new("euston", 1)
    expect(subject.zone).to eq(1)
end

  it "inits name" do
    subject = Station.new("euston", 1)
    expect(subject.name).to eq("euston")
  end
end
