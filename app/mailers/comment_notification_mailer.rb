class CommentNotificationMailer < ApplicationMailer
  def notify(user,bill)
    if user.is_a?(User)
      @receiver_name = Admin.find(user.admin_id).email
      @recipient_name = user.name
    else
      @receiver_name = bill.user.name
      @recipient_name = user.email
    end

    @bill_id = bill.id

    mail(to: user.email, subject: "Comment notification")
  end
end
