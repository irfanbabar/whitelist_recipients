# frozen_string_literal: true

if Rails::VERSION::MAJOR > 6
  Rails.application.configure do
    config.action_mailer.interceptors = [WhitelistRecipients::MailerInterceptor]
  end
else
  ActionMailer::Base.register_interceptor(WhitelistRecipients::MailerInterceptor)
end
