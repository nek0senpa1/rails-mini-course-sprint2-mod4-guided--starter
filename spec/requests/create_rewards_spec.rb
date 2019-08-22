require 'rails_helper'

RSpec.describe "Create Rewards", type: :request do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "create / rewards " do
    let(:reward_params) { { reward: { cost: 100, inventory: 25, name: "cool stuff yeah"} } }

    it "creates a new reward with the provided vals" do
      post rewards_path, params: reward_params
      json_body = JSON.parse(response.body).deep_symbolize_keys

      puts response.body
      
      expect(response).to have_http_status(201)
      expect(json_body).to include({
        name: "cool stuff yeah",
        inventory: 25,
        cost: 100
      })

      expect(json_body.keys).to contain_exactly(
        :cost, :created_at, :deactivated_at, :id, :inventory, :name, :purchase_count, :updated_at
      )

    end

  end


end
