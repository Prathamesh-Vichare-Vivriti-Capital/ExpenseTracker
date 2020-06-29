class CommentNotificationMailer < ApplicationMailer
  def notify(user,bill)
    if user.is_a?(User)
      @receiver_name = user.admin.name
      @recipient_name = user.name
    else
      @receiver_name = bill.user.name
      @recipient_name = user.name
    end

    @bill_id = bill.id

    mail(to: user.email, subject: "Comment notification")
  end

  def notify_bill_status(bill)
    @bill = bill
    mail(to: bill.user.email, subject: "Bill status")
  end
end
