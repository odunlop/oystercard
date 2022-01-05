require "oystercard"

describe Oystercard do

  let(:entry_station) {double :station, name: "London Bridge", zone: 1}
  let(:exit_station) {double :station, name: "Brixton", zone: 2}


  describe "#balance" do
    it "initially has a balance of 0" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "allows the user to top up their balance" do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it "raises an error when a top up will cause the balance to exceed £90" do
      max_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(max_balance)
      expect { subject.top_up(1) }.to raise_error "Balance cannot exceed £#{max_balance}"
    end
  end

  describe "#in_journey" do
    it "is initially not in a journey" do
      expect(subject).not_to be_in_journey
    end
  end

  describe "#touch_in" do
    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it "is in journey after touching in" do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it "raises an error if the balance is below the minumum fare" do
      expect { subject.touch_in(entry_station) }.to raise_error "You do not enough money on your card"
    end

    # it "remembers the station the user touched in at" do
    #   subject.top_up(5)
    #   subject.touch_in(entry_station)
    #   expect(current_journey.entry_station).to eq entry_station
    # end
  end

  describe "#touch_out" do
    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it "is not in journey after touching out" do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    it "deducts the minimum fare on touch out" do
      min_fare = Journey::MINIMUM_FARE
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-min_fare)
    end 

    # it "deducts the penalty fare when touching out without an entry station" do
    #   penalty = Journey::PENALTY_FARE
    #   subject.top_up(10)
    #   expect{ subject.touch_out(exit_station) }.to change{ subject.balance}.by(-penalty)
    # end

    it "clears current journey when tapping out" do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.current_journey).to eq nil
    end
  end

  describe ".journeys" do
    it "is intially an empty array" do
      expect(subject.journeys).to be_empty
    end

    # it "stores a journey after touching in" do
    #   journey = {entry_station: entry_station, exit_station: exit_station}
    #   subject.top_up(5)
    #   subject.touch_in(entry_station)
    #   subject.touch_out(exit_station)
    #   expect(subject.journeys).to include journey
    # end
  end
end