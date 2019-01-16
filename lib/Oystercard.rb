class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1

  attr_accessor :balance
  attr_reader :starting_station, :exit_station

  def initialize(balance = 0)
    @balance = balance
    @starting_station = nil
    @exit_station = nil
  end

  def top_up(amount)
    raise "You're over the limit #{LIMIT}" if (@balance + amount) >= LIMIT

    @balance += amount
  end


  def touch_in(starting_station)
    raise 'insufficient funds' if @balance < MINIMUM_FARE
    @starting_station = starting_station
  end

  def in_journey?
    @starting_station = !nil
  end

  def touch_out(exit_station)
    @balance -= MINIMUM_FARE
  
    @starting_station = nil
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end

end
