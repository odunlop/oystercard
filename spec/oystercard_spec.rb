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
  end
end