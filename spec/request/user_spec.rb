require 'rails_helper'

RSpec.describe 'users API', type: :request do
  #initialize test data
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }

  # Test suite for GET /api/users
  describe 'GET /api/users' do
    # make HTTP get request before each example
    before { get '/api/users' }

    it 'returns users' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  #Test suite for GET /api/users/:id
  describe 'GET /api/users/:id' do
    before { get "/api/users/#{user_id}" }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find User with 'id'=100\"}")
      end
    end
  end

  # Test suite for POST /api/users
  describe 'POST /api/users' do
    # valid creation data
    let(:valid_attributes) { { name: "Tim Duncan", email: "tim@duncan.com", password_digest: 'mypassword'}}

    context 'when the request is valid' do
      before { post '/api/users', params: valid_attributes }

      it 'creates an user' do
        expect(json['name']).to eq("Tim Duncan")
        expect(json['email']).to eq("tim@duncan.com")
        expect(json['password_digest']).to eq('mypassword')
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/users', params: { name: "Tim Duncan", email: "tim@duncan.com" } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"message\":\"Validation failed: Password digest can't be blank\"}")
      end
    end
  end

  # Test suite for PUT /api/users/:id
  describe 'PUT /api/users/:id' do
    let(:valid_attributes) { { name: 'Shaq Attack'} }

    context 'when the record exists' do
      before { put "/api/users/#{user_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/users/:id
  describe 'DELETE /api/users/:id' do
    before { delete "/api/users/#{user_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
