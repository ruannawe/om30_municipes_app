# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Faker::Config.locale = 'pt-BR'

def valid_cns_number?(number)
  return false unless number.match?(/\A[1-9]\d{14}\z/)

  sum = 0
  number.each_char.with_index do |char, index|
    sum += char.to_i * (15 - index)
  end

  sum % 11 == 0
end

def generate_cns(definitive: true)
  loop do
    prefix = definitive ? rand(1..2).to_s : rand(7..9).to_s
    cns_number = prefix + ('%014d' % rand(10**14))
    return cns_number if valid_cns_number?(cns_number)
  end
end

def generate_phone_number
  brazilian_country_code = '+55'
  brazilian_phone_number = Faker::PhoneNumber.phone_number

  "#{brazilian_country_code} #{brazilian_phone_number}"
end

100.times do |_i|
  byebug
  citizen = Citizen.create!(
    full_name: Faker::Name.name,
    tax_id: Faker::IDNumber.brazilian_citizen_number,
    national_health_card: generate_cns(definitive: [true, false].sample),
    email: Faker::Internet.email,
    birthdate: Faker::Date.between(from: '1950-01-01', to: '2000-12-31'),
    phone: generate_phone_number,
    photo: Faker::Avatar.image(size: '100x100', format: 'jpg'),
    status: [true, false].sample
  )

  address = Address.create!(
    citizen_id: citizen.id,
    zip_code: Faker::Address.postcode,
    street: Faker::Address.street_address,
    complement: Faker::Address.secondary_address,
    neighborhood: Faker::Address.community,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    ibge_code: Faker::Number.number(digits: 7)
  )
end
