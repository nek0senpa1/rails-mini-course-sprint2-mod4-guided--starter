class RewardPurchase
  def initialize(employee, reward)
    @employee = employee
    @reward = reward
  end

  def approved?
    @employee.can_afford?(@reward.cost) && @reward.available?
  end

  def notify
    NotificationService.send_purchase_approval(@employee.id, @reward.id)
  end
end
