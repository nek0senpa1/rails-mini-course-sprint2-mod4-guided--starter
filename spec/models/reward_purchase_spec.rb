require 'rails_helper'

RSpec.describe RewardPurchase do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "approved" do
    let(:unavailable_reward) { double("Reward", cost: 100, available?: false)}
    let(:available_reward) { double("Reward", cost: 100, available?: true)}

    context "emp can't afford" do
      let(:employee) { double("Employee", can_afford?: false)}

      context "reward AVAILABLE" do
        it "is not approved" do
          result = RewardPurchase.new(employee, available_reward).approved?

          expect(result).to be false
        end
      end

      context "reward UNavailable" do
        it "is not approved" do
          result = RewardPurchase.new(employee, unavailable_reward).approved?

          expect(result).to be false
        end
      end

      context "emp CAN afford" do
        let(:employee) { double("Employee", can_afford?: true)}

      context "reward AVAILABLE" do
        it "is not approved" do
          result = RewardPurchase.new(employee, available_reward).approved?

          expect(result).to be true
        end
      end

      context "reward UNavailable" do
        it "is not approved" do
          result = RewardPurchase.new(employee, unavailable_reward).approved?

          expect(result).to be false
        end
      end

      end

    end

  end



  describe "#notify" do
    let(:reward) { double("Reward", id: 17)}
    let(:employee) { double("Employee", id: 21)}

    context "with MOCK " do

      it "should call service with emp ID and reward ID" do
        expect(NotificationService).to receive(:send_purchase_approval).with(21,17)

        RewardPurchase.new(employee, reward).notify


      end

    end

    context " with SPY " do

      it "should call the service with id's" do

        allow(NotificationService).to receive(:send_purchase_approval)

        RewardPurchase.new(employee, reward).notify

        expect(NotificationService).to have_received(:send_purchase_approval).with(21,17)


      end
      
    end

  end

end
