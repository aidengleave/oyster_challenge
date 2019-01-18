require 'Oystercard'

RSpec.describe Oystercard do
    
  describe '#top_up' do
    it 'Raises an error if balance exceeds the limit' do
      limit = Oystercard::LIMIT
      expect { subject.top_up limit }.to raise_error "You're over the limit #{limit}"
    end
  end

  describe '#journeys' do
    let (:starting_station) { double :starting_station }
    let (:exit_station) { double :exit_station }

    it 'checks that a new card has an empty journey history' do
      expect(subject.journeys).to be_empty
    end


    it 'checks that initialized card journey is empty' do
      expect(subject.journey).to be_empty
    end

    it 'stores entry station' do
      subject.top_up(2)
      subject.touch_in(starting_station)
      subject.touch_out(exit_station)
      expect(subject.journey[:starting_station]).to eq starting_station
    end

    it 'stores exit station' do
      subject.top_up(2)
      subject.touch_in(starting_station)
      subject.touch_out(exit_station)
      expect(subject.journey[:exit_station]).to eq exit_station
    end

    # it 'stores start and exit stations as a journey' do
    #   subject.top_up(1)
    #   subject.touch_in(:starting_station)
    #   subject.touch_out(:exit_station)
    #   expect(subject.journeys).to include({entry: :starting_station, exit: :exit_station})

    # end
  end

  context 'Card behaviour during the journey' do
    let (:starting_station) { double starting_station }
    let (:exit_station) { double exit_station }

    it 'touch in saves starting station' do
      subject.top_up(2)
      expect(subject).to respond_to(:touch_in).with(1).argument
    end
    
    it 'touch out saves exit station' do
      expect(subject).to respond_to(:touch_out).with(1).argument

    end
    
    it 'card deducts fare on touch out' do
      fare = Oystercard::MINIMUM_FARE * -1
      subject.top_up(2)
      subject.touch_in(:starting_station)
      expect { subject.touch_out(:exit_station) }.to change { subject.balance }.by(fare)      
    end

    it 'Touch in changes journey status' do
      subject.top_up(2)
      subject.touch_in(:starting_station)
      expect(subject.journeys).not_to eq(nil)
    end

    it 'raises error if insufficient funds' do
      expect { subject.touch_in(:starting_station) }.to raise_error('insufficient funds')
    end
  end
end
