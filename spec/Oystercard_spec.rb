require 'Oystercard'

RSpec.describe Oystercard do
  it 'Card has a default balance of 0' do
    card = Oystercard.new
    expect(card.balance).to eq(0)
  end

  context '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can be topped up' do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end

    it 'Raises an error if balance exceeds £90' do
      expect{ subject.top_up Oystercard::LIMIT }.to raise_error "You're over the limit"
    end

  end

end
