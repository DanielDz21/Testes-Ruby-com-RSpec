FactoryBot.define do
  factory :weapon do
    name { FFaker::Lorem.word }
    description { FFaker::Lorem.paragraph }
    power_base { FFaker::Random.rand(1..99) }.to_s
    power_step { FFaker::Random.rand(1..10) }.to_s
    level { FFaker::Random.rand(1..99) }.to_s
  end
end
