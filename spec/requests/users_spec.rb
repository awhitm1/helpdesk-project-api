require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'POST /users' do
    context 'with valid attributes' do
      it 'creates a new user and returns a success response' do
        post '/users', params:  {user: attributes_for(:user) }
        expect(response).to have_http_status(:created)
        expect(User.count).to eq(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new user and returns an error response' do
        post '/users', params: {user: attributes_for(:user, email: nil)} 
        expect(response).to have_http_status(:unprocessable_entity)
        expect(User.count).to eq(0)
      end

      it 'does not create a new user and returns an error response' do
        post '/users', params: {user: attributes_for(:user, password: nil)} 
        expect(response).to have_http_status(:unprocessable_entity)
        expect(User.count).to eq(0)
      end
    end

  end

  describe 'GET /users' do
    it 'returns a success response' do
      get '/users'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /users/:id' do
    let! (:user) { create(:user) }

    context 'when the user exists' do
      before { get "/users/#{user.id}" }

      it 'returns the user' do
        expect(response).to have_http_status(:ok)
        user_response = JSON.parse(response.body)
        expect(user_response['id']).to eq(user.id)
      end
    end

    context 'when the user does not exist' do
      before { get "/users/9999" }

      it 'returns an error response' do
        expect(response).to have_http_status(:not_found)
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test not working yet
  # describe 'GET /users/:id/tickets' do
  #   2.times do
  #     let! (:user) { create(:user) }
  #   end
    
  #   let! (:ticket) { create(:ticket, user_id: 1, assigned_tech_id: 2, category_id: 1, location_id: 1, status_id: 1, group_id: 1) }
    
  #   context 'when the user exists' do
  #     before { get "/users/1/tickets" }

  #     it 'returns the user tickets' do
  #       expect(response).to have_http_status(:ok)
  #       user_response = JSON.parse(response.body)
  #       expect(user_response[0]['id']).to eq(ticket.id)
  #     end
  #   end

  #   context 'when the tech exists' do
  #     before { get "/users/#{user.id}/assigned_tickets" }

  #     it "returns the user's assigned tickets" do
  #       expect(response).to have_http_status(:ok)
  #       user_response = JSON.parse(response.body)
  #       expect(user_response[0]['assigned_tech_id']).to eq(2)
  #     end
  #   end
    
  # end
end
