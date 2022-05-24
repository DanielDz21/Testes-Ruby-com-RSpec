require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is invalid if the level is not between 1 and 99' do
    hero = build(:user, level: FFaker::Random.rand(100..9999))

    expect(hero).to be_invalid
  end

  it 'returns the correct hero title' do
    nickname = FFaker::Name.first_name
    kind = %i[knight wizard].sample
    level = rand(1..99)
    hero = create(:user, nickname: nickname, kind: kind, level: level)

    expect(hero.title).to eq("#{nickname} the #{kind} ##{level}")
  end
end
