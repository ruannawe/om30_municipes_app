# Preview all emails at http://localhost:3000/rails/mailers/citizen_mailer
class CitizenMailerPreview < ActionMailer::Preview
  def welcome_email
    citizen = Citizen.first
    CitizenMailer.with(citizen:).welcome_email(citizen)
  end

  def update_email
    citizen = Citizen.first
    CitizenMailer.with(citizen:).update_email(citizen)
  end
end
