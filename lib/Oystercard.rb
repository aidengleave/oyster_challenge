class Oystercard

  attr_reader :balance

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    if @balance >= 91
      fail "You're over the limit"
    elsif (@balance + amount) >= 91
      fail "You're over the limit"
    else
      @balance += amount
    end
  end

end
