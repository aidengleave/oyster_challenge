class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1

  attr_accessor :balance, :journey

  def initialize(balance = 0, journey = false)
    @balance = balance
    @journey = journey
  end

  def top_up(amount)
    raise "You're over the limit #{LIMIT}" if (@balance + amount) >= LIMIT

    @balance += amount
  end


  def touch_in
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
