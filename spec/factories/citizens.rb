require 'open-uri'
require 'cns_generator'
include CnsGenerator

FactoryBot.define do
  factory :citizen do
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

    trait :with_s3_image do
      after(:create) do |citizen|
        s3_image_url = "https://citizen-pictures.s3.amazonaws.com/nbevuzxpffvylvx35biulps4gr2c"
        image = URI.open(s3_image_url)

        citizen.photo.attach(
          io: image,
          filename: File.basename(URI.parse(s3_image_url).path),
          content_type: 'image/jpeg'
        )
      end
    end
  end
end
