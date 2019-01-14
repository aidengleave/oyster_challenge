class Oystercard

LIMIT = 91

  attr_reader :balance

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    if @balance >= LIMIT
      fail "You're over the limit"
    elsif (@balance + amount) >= LIMIT
      fail "You're over the limit"
    else
      @balance += amount
    end
  end

end
