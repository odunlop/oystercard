require_relative "journey"
require_relative "station"

class Oystercard
  attr_reader :balance, :current_journey, :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @current_journey = nil
    @journeys = []
  end

  def top_up(num)
    fail "Balance cannot exceed £#{MAXIMUM_BALANCE}" if @balance + num > MAXIMUM_BALANCE
    @balance += num
  end

  def in_journey?
    @current_journey
  end

  def touch_in(entry_station)
    fail "You do not enough money on your card" if @balance < MINIMUM_BALANCE
    @current_journey = Journey.new(entry_station)
    @journeys << @current_journey
  end 

  def touch_out(station)
    @current_journey.finish(station)
    deduct(@current_journey.fare)
    @current_journey = nil
  end

  private

  def deduct(num)
    @balance -= num
  end
end
