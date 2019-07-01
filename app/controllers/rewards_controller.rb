class RewardsController < ApplicationController
  def index
    @rewards = Reward.active

    render json: @rewards
  end

  def show
    @reward = Reward.find(params[:id])

    render json: @reward
  end

  def create
    @reward = Reward.new(reward_params)

    if @reward.save
      render json: @reward, status: :created, location: reward_url(@reward)
    else
      render json: @reward.errors, status: :unprocessable_entity
    end
  end

  private

  def reward_params
    params.require(:reward).permit(:cost, :inventory, :name)
  end
end
