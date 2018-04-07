class AccountMailer < ApplicationMailer
  def welcome_email(account)
    @account = account
    @url  = 'http://localhost:3000/admin/login'
    mail(to: @account.email, subject: 'Welcome to the JOIST-IMS Web Service!')
  end
end
