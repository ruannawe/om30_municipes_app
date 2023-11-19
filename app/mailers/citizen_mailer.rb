class CitizenMailer < ApplicationMailer
  default from: 'no-reply@yourdomain.com'

  def welcome_email(citizen)
    @citizen = citizen
    mail(to: @citizen.email, subject: 'Bem-vindo ao Sistema de Municípes - Confirmação de Cadastro')
  end

  def update_email(citizen)
    @citizen = citizen
    mail(to: @citizen.email, subject: 'Atualização de Informações do Munícipe')
  end
end
