require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it 'is invalid if the level is less than 0' do
    weapon = build(:weapon, level: -1)

    expect { raise weapon }.to raise_error(TypeError)
  end

  it 'returns the correct current_power' do
    weapon = create(:weapon, level: 3, power_base: 5, power_step: 5)
    expect(weapon.current_power).to eq(15)
  end

  it 'returns the correct title' do
    weapon = create(:weapon, name: 'Sword', level: 3)
    expect(weapon.title).to eq('Sword #3')
  end
end
