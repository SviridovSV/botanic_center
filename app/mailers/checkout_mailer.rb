class CheckoutMailer < ApplicationMailer
  def complete_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: "Your order #{@order.track_number} is accepted")
  end
end
