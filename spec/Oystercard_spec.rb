require 'Oystercard'

RSpec.describe Oystercard do
  it 'Card has a default balance of 0' do
    card = Oystercard.new
    expect(card.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can be topped up' do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end

    it 'Raises an error if balance exceeds £90' do
      limit = Oystercard::LIMIT
      expect { subject.top_up limit }.to raise_error "You're over the limit #{limit}"
    end
  end

  describe '#deduct_fare' do
    it { is_expected.to respond_to(:deduct_fare).with(1).argument }

    it 'deducts a fare from the balance' do
      expect { subject.deduct_fare 4 }.to change { subject.balance }.by -4
    end
  end

  context 'Card behaviour during the journey' do
    it 'User can touch out' do
      subject.top_up(2)
      subject.touch_in
      expect { subject.touch_out }. to change { subject.journey }.to false
    end

    it 'Touch in changes journey status' do
      subject.top_up(2)
      expect { subject.touch_in }. to change { subject.journey }.to true
    end

    it 'raises error if insufficient funds' do
      expect { subject.touch_in }.to raise_error('insufficient funds')
    end
  end
end
