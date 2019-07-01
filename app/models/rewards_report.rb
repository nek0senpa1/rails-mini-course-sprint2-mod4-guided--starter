class RewardsReport
  def initialize(rewards)
    @rewards = rewards.sort { |reward| reward.purchase_count }.reverse
  end

  def most_popular
    @rewards.first
  end

  def total_purchases
    @rewards.reduce { |total, reward| total + reward.purchase_count }
  end

  def notify
    NotificationService.send_purchase_report(total_purchases)
  end
end
