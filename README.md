# Whitelist Recipients

It is very simple tool to whitelist action mailer recipients, CC and BCC. This is specially helpful in staging environment, where you have replica of production environment including databases and you dont want to send mails to actual customers.

- Simple to use.
- Whitelist not only recipients but cc and bcc as well.
- Can enable/disable it in any environment.

## Compatibility

- **Ruby:** > 2.3

- **Rails:** >= 5

## Installation

Whitelist Recipients installation is simple and pretty standard.

```
    $ gem install whitelist_recipients
```

If you are using **Rails** and want to install through **bundler**, then just add this line to your **Gemfile**.

```
    gem 'whitelist_recipients'
```

Now generate initializer file by running following command.

```
    $ rails g whitelist_recipients:install
```

It will generate a file **whitelist_recipients.rb** in initializer folder. You dont have to do anything here.

```
    if Rails::VERSION::MAJOR > 6
        Rails.application.configure do
            config.action_mailer.interceptors = [WhitelistRecipients::MailerInterceptor]
        end
    else
        ActionMailer::Base.register_interceptor(WhitelistRecipients::MailerInterceptor)
    end
```

## Usage

Add following information in any of require environment files.

```
    config.action_mailer.smtp_settings = {
      :user_name => '<username>',
      :password => "<password>",
      :domain => '<example.com>',
      :address => '<smtp.dummy.net>',
      :port => <port>,
      :whitelist_email_addresses => %w[john@example.com],    # gem property
      :whitelist_mailer_cc => %w[johnny@example.com],           # gem property
      :whitelist_mailer_bcc => %w[johnnybravo@example.com] # gem property
  }
```

Now your require environment will send mail to above mentioned users. if recipient has different email address in action mailer function, then e-mail wont sent to them.

## Key Notes

- If you don't add any of the require property in smpt_settings then, environment can send mails to any user.
- If you put **empty array** inside **whitelist_email_addresses** property, it means, ActionMailer is disable, mail wont be sent to users.
- If whitelist_email_addresses has value, but **whitelist_mailer_cc** or **whitelist_mailer_bcc** are empty array. it means, cc and bcc wont send to require email addresses even if you have added value in action mailer function

```
	# john@example.com will receive mail (if added in whitelist_email_addresses)
    # johnny@example.com, johnnybravo@example.com will not receive any mail.

	mail(to: 'john@example.com', cc: 'johnny@example.com', bcc: 'johnnybravo@example.com')
```

- If you want to whitelist only **cc** or **bcc** then put property inside smtp_setting but don't put **whitelist_email_addresses** property. like this

```
    config.action_mailer.smtp_settings = {
      :user_name => '<username>',
      :password => "<password>",
      :domain => '<example.com>',
      :address => '<smtp.dummy.net>',
      :port => <port>,
      :whitelist_mailer_cc => %w[johnny@example.com],      # gem property
           # OR
      :whitelist_mailer_bcc => %w[johnnybravo@example.com] # gem property
  }
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/irfanbabar/whitelist_recipients. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/irfanbabar/whitelist_recipients/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Whitelist Recipients project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/irfanbabar/whitelist_recipients/blob/main/CODE_OF_CONDUCT.md/blob/main/CODE_OF_CONDUCT.md).
