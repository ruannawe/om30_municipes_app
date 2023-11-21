require 'sendgrid-ruby'
include SendGrid

class SendGridActionMailer
  def initialize(*args)
    values = args.extract_options!
    @settings = {
      api_key: ENV.fetch('SENDGRID_API_KEY', nil),
      raise_delivery_errors: true
    }.merge!(values)
  end

  attr_accessor :settings

  def deliver!(mail)
    # Construct the 'from', 'subject', 'to', and 'content' for SendGrid
    from_email = Email.new(email: mail.from_addrs.first)
    to_email = Email.new(email: mail.to_addrs.first)
    subject = mail.subject
    content = Content.new(type: 'text/html', value: mail.body.encoded)

    # Create the SendGrid mail object
    sg_mail = SendGrid::Mail.new
    sg_mail.from = from_email
    sg_mail.subject = subject

    personalization = Personalization.new
    personalization.add_to(to_email)
    sg_mail.add_personalization(personalization)
    sg_mail.add_content(content)

    # Send the email
    sg = SendGrid::API.new(api_key: settings[:api_key])
    response = sg.client.mail._('send').post(request_body: sg_mail.to_json)

    # Handle the response
    raise response.body unless response.status_code.to_s =~ /^2\d\d$/
  end
end

ActionMailer::Base.add_delivery_method :sendgrid_actionmailer, SendGridActionMailer
