require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  it 'instantiates with a balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it 'tops up the card' do
    expect(oystercard.top_up(10)).to eq 10
  end

  it 'updates the balance' do
    oystercard.top_up(10)
    expect(oystercard.balance).to eq 10
  end

end
