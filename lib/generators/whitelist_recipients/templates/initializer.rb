if Rails::VERSION::MAJOR > 6
  Rails.application.configure do
    if Rails.env.staging?
      config.action_mailer.interceptors = [WhitelistRecipients::MailerInterceptor]
    end
  end
else
  ActionMailer::Base.register_interceptor(WhitelistRecipients::MailerInterceptor)
end

