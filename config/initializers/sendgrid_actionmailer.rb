require 'sendgrid-ruby'
include SendGrid

class SendGridActionMailer
  def initialize(values)
    self.settings = { return_response: true }.merge!(values)
  end

  attr_accessor :settings

  def deliver!(mail)
    from = Email.new(email: mail.from.first)
    subject = mail.subject
    to = Email.new(email: mail.to.first)
    content = Content.new(type: 'text/plain', value: mail.body.raw_source)

    mail = Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: settings[:api_key])

    response = sg.client.mail._('send').post(request_body: mail.to_json)
    raise response.body unless response.status_code.to_s =~ /^2\d\d$/
  end
end

ActionMailer::Base.add_delivery_method :sendgrid_actionmailer, SendGridActionMailer
