class Oystercard
  attr_reader :balance, :entry_station

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(num)
    fail "Balance cannot exceed £#{MAXIMUM_BALANCE}" if @balance + num > MAXIMUM_BALANCE
    @balance += num
  end

  def in_journey?
    @entry_station
  end

  def touch_in(entry_station)
    fail "You do not enough money on your card" if @balance < MINIMUM_FARE
    @in_journey = true
    @entry_station = entry_station
  end 

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private

  def deduct(num)
    @balance -= num
  end

end