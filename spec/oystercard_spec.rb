require "oystercard"

describe Oystercard do

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

  describe "#deduct" do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it "allows journey fare to be deducted from the card" do
      subject.top_up(10)
      subject.deduct(5)
      expect(subject.balance).to eq 5
    end
  end

  describe "#in_journey" do
    it "is initially not in a journey" do
      expect(subject).not_to be_in_journey
    end
  end

  describe "#touch_in" do
    it { is_expected.to respond_to(:touch_in) }

    it "is in journey after touching in" do
      subject.top_up(5)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it "raises an error if the balance is below the minumum fare" do
      expect { subject.touch_in }.to raise_error "You do not enough money on your card"
    end
  end

  describe "#touch_out" do
    it { is_expected.to respond_to(:touch_out) }

    it "is not in journey after touching out" do
      subject.top_up(5)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end