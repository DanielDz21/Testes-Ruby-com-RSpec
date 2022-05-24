require 'rails_helper'

RSpec.describe 'Weapons', type: :request do
  describe 'GET /weapons' do
    it 'returns success status' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it "the weapons's name is present" do
      weapons = create_list(:weapon, 3)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include(weapon.name)
      end
    end

    it "the weapons's current_power is present" do
      weapons = create_list(:weapon, 3)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include(weapon.current_power.to_s)
      end
    end

    it "the weapons's links to the show page" do
      weapons = create_list(:weapon, 3)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include(weapon_path(weapon))
      end
    end
  end

  describe 'POST /weapons' do
    context 'when it has valid params' do
      it 'creates the weapon with correct attributes' do
        weapon_attributes = FactoryBot.attributes_for(:weapon)
        post weapons_path, params: { weapon: weapon_attributes }
        expect(Weapon.last).to have_attributes(weapon_attributes)
      end
    end

    context 'when it has no valid parameters' do
      it 'does not create weapon' do
        expect { post weapons_path, params: { weapon: { name: '' } } }.to_not change(Weapon, :count)
      end
    end
  end

  describe 'DELETE /weapons' do
    it 'deletes the weapon' do
      weapon = create_list(:weapon, 3)
      expect { delete weapon_path(weapon) }.to change(Weapon, :count).by(-1)
    end
  end

  describe 'GET /weapons/:id' do
    it 'renders the fields' do
      weapon = create(:weapon)
      get weapon_path(weapon)
      expect(response.body).to include(weapon.name)
      expect(response.body).to include(weapon.description)
      expect(response.body).to include(weapon.power_base.to_s)
      expect(response.body).to include(weapon.power_step.to_s)
      expect(response.body).to include(weapon.level.to_s)
    end
  end
end
