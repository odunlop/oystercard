require "journey"

describe Journey do
  let(:station) { double :station, name: "London Bridge", zone: 1}
  let(:station2) { double :station, name: "Brixton", zone: 2}

  it "knows if a journey has been completed or not" do
    expect(subject).not_to be_complete
  end

  describe "#fare" do

    it "returns the penalty fare if the user does not tap out" do
      journey = Journey.new(station)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it "returns the penalty fare if the user does not tap in" do
      subject.finish(station2)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it "returns the minimum fare for a completed journey" do
      journey = Journey.new(station)
      journey.finish(station2)
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end
  end
end