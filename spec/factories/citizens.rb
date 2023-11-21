FactoryBot.define do
  factory :citizen do
    full_name { 'John Doe' }
    tax_id { CPF.generate(true) }
    national_health_card { '239233319950009' }
    email { 'john@example.com' }
    birthdate { '1980-01-01' }
    phone { '+55 (69) 99568-5323' }
    photo { 'path/to/photo.jpg' }
    status { false }

    after(:build) do |citizen|
      citizen.address ||= build(:address, citizen:)
    end
  end
end
