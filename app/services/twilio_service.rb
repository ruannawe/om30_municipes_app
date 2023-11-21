class TwilioService
  TEMPLATES = {
    welcome: 'Bem-vindo ao Sistema de Munícipes! Seu cadastro foi realizado com sucesso. Acesse nosso site para mais informações.',
    update: 'Informamos que seus dados no Sistema de Munícipes foram atualizados. Por favor, verifique suas informações no seu perfil ou entre em contato para qualquer discrepância.'
  }

  def self.send_sms(to:, template_key:)
    body = TEMPLATES[template_key]
    raise 'Template inválido' unless body

    client = Twilio::REST::Client.new
    client.messages.create(
      from: '+16066033043',
      to:,
      body:
    )
  rescue StandardError
    # Ignoring any exceptions
  end
end
