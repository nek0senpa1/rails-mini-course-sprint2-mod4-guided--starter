require 'rails_helper'

RSpec.describe Reward, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "validations" do
    it "is valid" do
      reward = Reward.new(cost: 50, name: "Cool Rewards")
      result = reward.valid?
      errors = reward.errors.full_messages

      expect(result).to be(true)
      expect(errors).to be_empty


    end

    it "is invalid without a name" do
      reward = Reward.new(cost: 50, name: nil)
      result = reward.valid?
      errors = reward.errors.full_messages

      expect(result).to be(false)
      expect(errors).to include("Name can't be blank")

    end
    
    it "is invalid without a cost" do
      reward = Reward.new(cost: nil, name: "Cool Rewards")
      result = reward.valid?
      errors = reward.errors.full_messages

      expect(reward.valid?).to be false
      expect(reward.errors.full_messages).to include("Cost can't be blank")
    end

  end



  describe "attributes" do
    it "has expected attributes" do
      reward = Reward.new(cost: 50, name: "stuff of stuff")

      result = reward.attribute_names.map { |name| name.to_sym }

      expect(result).to contain_exactly(
        :cost,
        :created_at,
        :deactivated_at,
        :id,
        :inventory,
        :name,
        :purchase_count,
        :updated_at
      )
      
    end
    
  end

  describe "scopes" do

    describe ".active" do
      
      before do
        Reward.create!([
          { name: "Reward A", cost: 100, deactivated_at: nil},
          { name: "Reward B", cost: 100, deactivated_at: nil},
          { name: "Reward C", cost: 100, deactivated_at: Time.now}
        ])
      end

      it "returns list of rewards" do
        results = Reward.active

        expect(results.count).to eq 2
        expect(results.first.name).to eq "Reward A"
        expect(results.any? { |r| r.name == "Reward C"}).to be false 
      end

    end

  end

  describe "instance methods" do

    describe "#available?" do
      context "with available inventory" do
        let(:reward) { Reward.new(inventory:1, deactivated_at: nil)}
        
        it "is avail when not deac" do
          result = reward.available?

          expect(result).to be true
        end

        it "is not avail when deac" do
          reward.deactivated_at = Time.now
          result = reward.available?

          expect(result).to be false

        end

      end

      context "with no inventory" do
        let(:reward) { Reward.new(inventory:0, deactivated_at: nil)}

        it "is avail when not deac" do
          result = reward.available?

          expect(result).to be false
        end

        it "is not avail when deac" do
          reward.deactivated_at = Time.now
          result = reward.available?

          expect(result).to be false

        end

      end

    end


    describe "restock stuff" do
      context "when deactivated" do
        let(:reward) {Reward.create!(cost: 50, name: "cool shit", inventory: 19, deactivated_at: Time.now)}

        it "restocks to 25 and activates" do
          result = reward.restock
          restocked_award = Reward.find(reward.id)

          expect(result).to be true
          expect(restocked_award.deactivated_at).to be_nil
          expect(restocked_award.inventory).to eq 25

        end

      end

      context "when active" do

      end

    end

  end

end
