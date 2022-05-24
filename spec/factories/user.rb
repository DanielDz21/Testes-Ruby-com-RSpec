FactoryBot.define do
  factory :user do
    nickname { FFaker::Name.first_name }
    level { FFaker::Random.rand(1..99) }
    kind { %w[knight wizard].sample }
  end
end
