require 'station'

describe Station do
  new_station = Station.new("London Bridge", 1)

  it "can view the name of a station" do
    expect(new_station.name).to eq "London Bridge"
  end

  it "can view the zone number of a station" do
    expect(new_station.zone).to eq 1
  end
end