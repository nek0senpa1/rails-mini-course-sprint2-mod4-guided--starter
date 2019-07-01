# this is a fake object that pretends to be an expensive operation
class NotificationService
  def self.send_purchase_approval(*args)
    sleep 25
  end

  def self.send_purchase_report(*args)
    sleep 25
  end
end
