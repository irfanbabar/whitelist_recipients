# frozen_string_literal: true

# methods to whitelist email address
module MailerInterceptorModule
  # whitelist email addresses
  def delivering_email(message)
    return unless message.perform_deliveries
    return unless !!Rails.application.config.action_mailer&.smtp_settings

    smtp_settings = Rails.application.config.action_mailer.smtp_settings
    whitelist = smtp_settings[:whitelist_email_addresses]
    whitelist_cc = smtp_settings[:whitelist_mailer_cc]
    whitelist_bcc = smtp_settings[:whitelist_mailer_bcc]

    finalize_email_addresses(whitelist, message)

    finalize_cc(whitelist_cc, message)

    finalize_bcc(whitelist_bcc, message)
  end

  # ======================================
  # =========== Private Methods ==========
  # ======================================
  private

  def check_requirements?(filtered_data, actual_data)
    !filtered_data.nil? and actual_data.present?
  end

  def finalize_email_addresses(whitelist, message)
    return unless check_requirements?(whitelist, message.to)

    final_whitelist = message.to.select { |receiver| whitelist.include? receiver }
    message.to = final_whitelist

    return unless final_whitelist.blank?

    message.to = []
    message.perform_deliveries = false # stop sending mail
  end

  def finalize_cc(whitelist, message)
    return unless check_requirements?(whitelist, message.cc)

    final_whitelist_cc = message.cc.select { |receiver| whitelist.include? receiver }
    message.cc = final_whitelist_cc
  end

  def finalize_bcc(whitelist, message)
    return unless check_requirements?(whitelist, message.bcc)

    final_whitelist_bcc = message.bcc.select { |receiver| whitelist.include? receiver }
    message.bcc = final_whitelist_bcc
  end
end
