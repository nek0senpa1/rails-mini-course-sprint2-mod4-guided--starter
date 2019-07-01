class Employee < ApplicationRecord
  validates :first_name, :last_name, presence: true

  scope :zero_balance, -> { where("rewards_balance <= ?", 0) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def can_afford?(reward_cost)
    rewards_balance >= reward_cost
  end
end
