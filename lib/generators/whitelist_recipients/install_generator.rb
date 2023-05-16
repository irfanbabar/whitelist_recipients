# frozen_string_literal: true

require 'rails/generators'
module WhitelistRecipients
  # generate a whitelist_recipients.rb file in initializers
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    def copy_initializer
      template 'initializer.rb', 'config/initializers/whitelist_recipients.rb'
    end
  end
end
