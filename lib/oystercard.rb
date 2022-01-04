class Oystercard
  attr_reader :balance, :entry_station, :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
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
    @entry_station = entry_station
  end 

  def touch_out(exit_station)
    @exit_station = exit_station
    deduct(MINIMUM_FARE)
    save_journey(@entry_station, @exit_station)
    @entry_station, @exit_station = nil, nil
  end

  private

  def deduct(num)
    @balance -= num
  end

  def save_journey(entry_station, exit_station)
    journey = {entry_station: @entry_station, exit_station: exit_station}
    journeys.push(journey)
  end
end