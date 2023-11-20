require 'sendgrid-ruby'
include SendGrid

class SendGridActionMailer
  def initialize
    # Set up the settings directly within the initializer
    @settings = {
      api_key: ENV['SENDGRID_API_KEY'], # Ensure this environment variable is set
      raise_delivery_errors: true
    }
  end

  attr_accessor :settings

  def deliver!(mail)
    # Set up the email components
    from = Email.new(email: mail.from.first)
    subject = mail.subject
    to = Email.new(email: mail.to.first)
    content = Content.new(type: 'text/plain', value: mail.body.raw_source)

    # Construct the email using SendGrid's classes
    mail = Mail.new(from, subject, to, content)

    # Initialize SendGrid API client
    sg = SendGrid::API.new(api_key: @settings[:api_key])

    # Send the email
    response = sg.client.mail._('send').post(request_body: mail.to_json)

    # Optionally raise an error if the response is not a success
    raise response.body unless response.status_code.to_s =~ /^2\d\d$/
  end
end

# Add the custom delivery method to ActionMailer
ActionMailer::Base.add_delivery_method :sendgrid_actionmailer, SendGridActionMailer
