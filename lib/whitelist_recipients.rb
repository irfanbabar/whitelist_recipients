# frozen_string_literal: true

require_relative 'whitelist_recipients/version'
require_relative 'whitelist_recipients/mailer_interceptor'

module WhitelistRecipients
  class Error < StandardError; end
  # Your code goes here...
  class MailerInterceptor
    extend MailerInterceptorModule
  end
end
