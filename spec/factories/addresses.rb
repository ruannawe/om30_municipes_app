FactoryBot.define do
  factory :address do
    citizen
    zip_code { "12345" }
    street { "123 Main St" }
    complement { "Apt 101" }
    neighborhood { "Downtown" }
    city { "Metropolis" }
    state { "State" }
    ibge_code { "1234567" }
  end
end
