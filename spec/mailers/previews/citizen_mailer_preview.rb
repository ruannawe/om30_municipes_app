# Preview all emails at http://localhost:3000/rails/mailers/citizen_mailer
class CitizenMailerPreview < ActionMailer::Preview
  def welcome_email
    citizen =  Citizen.first
    CitizenMailer.with(citizen: citizen).welcome_email(citizen)
  end
end
