class Oystercard
  LIMIT = 91

  attr_accessor :balance, :journey

  def initialize(balance = 0, journey = false)
    @balance = balance
    @journey = journey
  end

  def top_up(amount)
    raise "You're over the limit #{LIMIT}" if (@balance + amount) >= LIMIT

    @balance += amount
  end

  def deduct_fare(fare)
    @balance -= fare
  end

  def touch_in
    raise 'insufficient funds' if @balance < 1

    @journey = true
  end

  def touch_out
    @journey = false
  end

  # def in_journey?
  #
  # end
end
