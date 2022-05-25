require 'rails_helper'

RSpec.describe 'Enemies', type: :request do
  # describe 'PUT /enemies' do
  #   context 'when the enemy exists' do
  #     let(:enemy) { create(:enemy) }
  #     let(:enemy_attributes) { attributes_for(:enemy) }

  #     before(:each) { put "/enemies/#{enemy.id}", params: { enemy: enemy_attributes } }

  #     it 'returns status code 200' do
  #       expect(response).to have_http_status(200)
  #     end

  #     it 'updates the enemy' do
  #       expect(enemy.reload).to have_attributes(enemy_attributes)
  #     end

  #     it 'returns the updated enemy' do
  #       expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at'))
  #     end
  #   end

  #   context 'when the enemy does not exist' do
  #     before(:each) { put '/enemies/0', params: attributes_for(:enemy) }

  #     it 'returns status code 404' do
  #       expect(response).to have_http_status(404)
  #     end

  #     it 'returns a not found message' do
  #       expect(response.body).to match(/Couldn't find Enemy/)
  #     end
  #   end
  # end

  # describe 'DELETE /enemies' do
  #   context 'when the enemy exists' do
  #     let(:enemy) { create(:enemy) }
  #     before(:each) { delete "/enemies/#{enemy.id}" }

  #     it 'returns status code 204' do
  #       expect(response).to have_http_status(204)
  #     end

  #     it 'deletes the enemy' do
  #       expect { enemy.reload }.to raise_error(ActiveRecord::RecordNotFound)
  #     end
  #   end

  #   context 'when the enemy does not exist' do
  #     before(:each) { delete '/enemies/0' }

  #     it 'returns status code 404' do
  #       expect(response).to have_http_status(404)
  #     end

  #     it 'returns a not found message' do
  #       expect(response.body).to match(/Couldn't find Enemy/)
  #     end
  #   end
  # end

  describe 'GET /enemies' do
    before(:each) { get '/enemies' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns all enemies' do
      expect(json.size).to eq(Enemy.count)
    end
  end

  describe 'GET /enemies/:id' do
    context 'when the enemy exists' do
      let(:enemy) { create(:enemy) }
      before(:each) { get "/enemies/#{enemy.id}" }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the enemy' do
        expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at'))
      end
    end

    context 'when the enemy does not exist' do
      before(:each) { get '/enemies/0' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe 'POST /enemies' do
    context 'when the request is valid' do
      let(:enemy_attributes) { attributes_for(:enemy) }
      before(:each) { post '/enemies', params: enemy_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'creates the enemy' do
        expect(Enemy.find(json['id'])).to have_attributes(enemy_attributes)
      end
    end

    context 'when the request is invalid' do
      let(:enemy_attributes) { attributes_for(:enemy, name: nil) }
      before(:each) { post '/enemies', params: enemy_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Name can't be blank/)
      end
    end
  end
end
