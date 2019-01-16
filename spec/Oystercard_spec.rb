require 'Oystercard'

RSpec.describe Oystercard do

  describe '#top_up' do
    it 'Raises an error if balance exceeds the limit' do
      limit = Oystercard::LIMIT
      expect { subject.top_up limit }.to raise_error "You're over the limit #{limit}"
    end
  end

  context 'Card behaviour during the journey' do
    let (:station) {double starting_station}
    it 'touch in saves starting station' do
      subject.top_up(2)
      expect(subject).to respond_to(:touch_in).with(1).argument

    end
    it 'User can touch out' do
      subject.top_up(2)
      subject.touch_in(:station)
      expect { subject.touch_out }. to change { subject.starting_station }.to nil
    end

    it 'card deducts fare on touch out' do
      fare = Oystercard::MINIMUM_FARE * -1
      subject.top_up(2)
      subject.touch_in(:station)
      expect { subject.touch_out }.to change { subject.balance }.by(fare)      
    end

    it 'Touch in changes journey status' do
      subject.top_up(2)
      subject.touch_in(:station)
      expect(subject.starting_station).not_to eq(nil)
    end

    it 'raises error if insufficient funds' do
      expect { subject.touch_in(:station) }.to raise_error('insufficient funds')
    end
  end
end
