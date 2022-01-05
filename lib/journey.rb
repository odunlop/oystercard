class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry = nil)
    @entry_station = entry
    @exit_station = nil
  end

  def fare
    complete? == true ? MINIMUM_FARE : PENALTY_FARE
  end

  def finish(station)
    @exit_station = station
  end

  def complete?
    @entry_station && @exit_station ? true : false
  end
end