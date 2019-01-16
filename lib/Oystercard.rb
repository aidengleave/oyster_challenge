class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1

  attr_accessor :balance, :journey
  attr_reader :starting_station

  def initialize(balance = 0, journey = false)
    @balance = balance
    @journey = journey
    @starting_station = nil
  end

  def top_up(amount)
    raise "You're over the limit #{LIMIT}" if (@balance + amount) >= LIMIT

    @balance += amount
  end


  def touch_in(starting_station)
    raise 'insufficient funds' if @balance < MINIMUM_FARE

    @journey = true
  end

  def touch_out
    @balance -= MINIMUM_FARE
  
    @journey = false
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end

end
