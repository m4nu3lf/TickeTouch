class UserMailer < ActionMailer::Base
  default from: "ticketouch@gmail.com"

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registrazione su TickeTouch")
  end

  def purchase_confirmation(user, purchase)
    @user = user
    @purchase = purchase
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Il Tuo Acquisto Su TickeTouch ")
  end


end
