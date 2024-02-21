require 'rails_helper'

RSpec.describe "Tickets", type: :request do
  describe 'POST /tickets' do
    let(:user) { create(:user) }
    let(:token) { auth_token_for_user(user) }
    let(:ticket) { create(:ticket) }

    context 'with valid attributes' do
      it 'creates a new ticket and returns a success response' do
        post '/tickets', params:  { ticket: attributes_for(:ticket) }, , headers: { Authorization: "Bearer #{token}" }
        expect(response).to have_http_status(:created)
        expect(Ticket.count).to eq(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new ticket and returns an error response' do
        post '/tickets', params: {ticket: attributes_for(:ticket, title: nil)}, headers: { Authorization: "Bearer #{token}" } 
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Ticket.count).to eq(0)
      end

      it 'does not create a new ticket and returns an error response' do
        post '/tickets', params: {ticket: attributes_for(:ticket, description: nil)}, headers: { Authorization: "Bearer #{token}" } 
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Ticket.count).to eq(0)
      end
    end
  end

  describe 'GET /tickets' do
    let(:ticket) { create(:ticket) } 
    let(:token) { auth_token_for_user(ticket.user) }

    before do
      ticket
      get '/tickets', headers: { Authorization: "Bearer #{token}" }
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a list of all tickets' do
      expect(response).to eq(Ticket.all.to_json)
    end
  end

  describe 'GET /tickets/:id' do
    let! (:ticket) { create(:ticket) }
    let  (:token) { auth_token_for_user(ticket.user) }

    context 'when the ticket exists' do
      before do
        ticket
        get "/tickets/#{ticket.id}", headers: { Authorization: "Bearer #{token}" }
      end
      
      it 'returns the ticket' do
        expect(response).to have_http_status(:ok)
        ticket_response = JSON.parse(response.body)
        expect(ticket_response['id']).to eq(ticket.id)
      end
    end

    context 'when the ticket does not exist' do
      before do
        ticket
        get "/tickets/#{ticket.id + 1}", headers: { Authorization: "Bearer #{token}" }
      end
      
      it 'returns an error response' do
        expect(response).to have_http_status(:not_found)
      end
end
