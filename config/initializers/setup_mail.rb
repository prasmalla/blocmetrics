ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:        'smtp.sendgrid.net',
  port:           '587',
  authentication: :plain,
  user_name:      ENV['SENDGRID_USERNAME'],
  password:       ENV['SENDGRID_PASSWORD'],
  domain:         'heroku.com',
  enable_starttls_auto: true
}

class MailInterceptor
  def self.delivering_email(message)
    receiver = message.to
    message.to =  ENV['INTERCEPT_EMAIL']
    message.cc = nil
    message.bcc = nil
    message.subject << " #{receiver}"
  end
end
# intercept outgoing emails in development
ActionMailer::Base.register_interceptor(MailInterceptor) if Rails.env.development?
