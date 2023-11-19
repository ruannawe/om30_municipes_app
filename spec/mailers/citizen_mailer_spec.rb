require "rails_helper"

RSpec.describe CitizenMailer, type: :mailer do
  describe 'welcome_email' do
    let(:citizen) { create(:citizen, email: 'test@example.com') }
    let(:mail) { CitizenMailer.welcome_email(citizen) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Bem-vindo ao Sistema de Municípes - Confirmação de Cadastro')
      expect(mail.to).to eq(['test@example.com'])
      expect(mail.from).to eq(['no-reply@yourdomain.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(citizen.full_name)
      expect(mail.body.encoded).to match(citizen.national_health_card)
      expect(mail.body.encoded).to match(citizen.birthdate.to_s)
      expect(mail.body.encoded).to match(citizen.phone)
      expect(mail.body.encoded).to match(citizen.email)
    end
  end

  describe 'update_email' do
    let(:citizen) { create(:citizen, email: 'test@example.com') }
    let(:mail) { CitizenMailer.update_email(citizen) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Atualização de Informações do Munícipe')
      expect(mail.to).to eq(['test@example.com'])
      expect(mail.from).to eq(['no-reply@yourdomain.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(citizen.full_name)
      expect(mail.body.encoded).to match(citizen.national_health_card)
      expect(mail.body.encoded).to match(citizen.birthdate.to_s)
      expect(mail.body.encoded).to match(citizen.phone)
      expect(mail.body.encoded).to match(citizen.email)
    end
  end
end
