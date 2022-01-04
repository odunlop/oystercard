class Oystercard
  attr_reader :balance, :in_journey

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(num)
    fail "Balance cannot exceed £#{MAXIMUM_BALANCE}" if @balance + num > MAXIMUM_BALANCE
    @balance += num
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "You do not enough money on your card" if @balance < MINIMUM_FARE
    @in_journey = true
  end 

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
  end

  private

  def deduct(num)
    @balance -= num
  end

end