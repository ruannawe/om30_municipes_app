# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'cns_generator'
include CnsGenerator

100.times do |_i|
  citizen = Citizen.create!(
    full_name: Faker::Name.name,
    tax_id: Faker::IDNumber.brazilian_citizen_number,
    national_health_card: generate_cns(definitive: [true, false].sample),
    email: Faker::Internet.email,
    birthdate: Faker::Date.between(from: '1950-01-01', to: '2000-12-31'),
    phone: '+55 ' + Faker::PhoneNumber.phone_number,
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
