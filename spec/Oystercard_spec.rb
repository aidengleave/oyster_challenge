require 'Oystercard'

RSpec.describe Oystercard do

  describe '#top_up' do
    it 'Raises an error if balance exceeds the limit' do
      limit = Oystercard::LIMIT
      expect { subject.top_up limit }.to raise_error "You're over the limit #{limit}"
    end
  end

  describe '#deduct_fare' do
    
    it 'deducts a fare from the balance' do
      subject.top_up(4)
      expect { subject.deduct_fare 4 }.to change { subject.balance }.by -4
    end
  end

  context 'Card behaviour during the journey' do
    it 'User can touch out' do
      subject.top_up(2)
      subject.touch_in
      expect { subject.touch_out }. to change { subject.journey }.to false
    end

    it 'card deducts fare on touch out' do
      fare = Oystercard::MINIMUM_FARE * -1
      subject.top_up(2)
      subject.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by(fare)      
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
