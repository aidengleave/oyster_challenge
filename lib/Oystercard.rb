class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1

  attr_accessor :balance, :journey, :journeys
  attr_reader :starting_station, :exit_station

  def initialize(balance = 0)
    @balance = balance
    @starting_station = nil
    @exit_station = nil
    @journeys = []
    @journey = {}
  end

  def top_up(amount)
    raise "You're over the limit #{LIMIT}" if (@balance + amount) >= LIMIT

    @balance += amount
  end

  def touch_in(starting_station)
    raise 'insufficient funds' if @balance < MINIMUM_FARE

    @journey[:starting_station] = starting_station 

    #@starting_station = starting_station
    end

  def in_journey?
    journey[:starting_station] = starting_station
  end

  def touch_out(exit_station)
    @journey[:exit_station] = exit_station 
    @balance -= MINIMUM_FARE
    @journeys << @journey
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end
end
