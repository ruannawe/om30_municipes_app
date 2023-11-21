require 'cns_generator'

FactoryBot.define do
  factory :citizen do
    include CnsGenerator

    full_name { 'John Doe' }
    tax_id { CPF.generate(true) }
    national_health_card { generate_cns(definitive: [true, false].sample) }
    email { Faker::Internet.unique.email }
    birthdate { Faker::Date.between(from: '1950-01-01', to: '2000-12-31') }
    phone { '+55 ' + Faker::PhoneNumber.phone_number }
    status { false }

    after(:build) do |citizen|
      citizen.address ||= build(:address, citizen:)
    end

    after(:create) do |citizen|
      citizen.photo.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.jpeg')),
        filename: 'test_image.jpeg',
        content_type: 'image/jpeg'
      )
    end
  end
end
