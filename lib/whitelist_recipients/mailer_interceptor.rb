
module MailerInterceptorModule
  # whitelist email addresses
  def delivering_email(message)
    whitelist = Rails.application.config.action_mailer.smtp_settings[:whitelist_email_addresses]
    whitelist_cc = Rails.application.config.action_mailer.smtp_settings[:whitelist_mailer_cc]
    whitelist_bcc = Rails.application.config.action_mailer.smtp_settings[:whitelist_mailer_bcc]

    # ignore feature if smtp_settings[:whitelist_email_addresses] not set
    if !whitelist.nil? and message.to.present?
      final_whitelist = message.to.select {|receiver| whitelist.include? receiver }
      message.to = final_whitelist
      if final_whitelist.blank?
        message.to = []
        message.perform_deliveries = false # stop sending mail
      end
    end
    if !whitelist_cc.nil? and message.cc.present? and message.perform_deliveries
      final_whitelist_cc = message.cc.select {|receiver| whitelist_cc.include? receiver}
      message.cc = final_whitelist_cc
    end
    if !whitelist_bcc.nil? and message.bcc.present? and message.perform_deliveries
      final_whitelist_bcc = message.bcc.select {|receiver| whitelist_bcc.include? receiver}
      message.bcc = final_whitelist_bcc
    end
  end
end
