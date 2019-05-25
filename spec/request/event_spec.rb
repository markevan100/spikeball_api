require 'rails_helper'

RSpec.describe 'events API', type: :request do
  #initialize test data
  let!(:events) { create_list(:event, 10) }
  let(:event_id) { events.first.id }

  # Test suite for GET /api/events
  describe 'GET /api/events' do
    # make HTTP get request before each example
    before { get '/api/events' }

    it 'returns events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  #Test suite for GET /api/events/:id
  describe 'GET /api/events/:id' do
    before { get "/api/events/#{event_id}" }

    context 'when the record exists' do
      it 'returns the event' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:event_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find Event with 'id'=100\"}")
      end
    end
  end

  # Test suite for POST /api/events
  describe 'POST /api/events' do
    # valid creation data
    let(:valid_attributes) { { creator: 55, timing: "2020-09-19 07:03:30", where: 'Wash Park'}}

    context 'when the request is valid' do
      before { post '/api/events', params: valid_attributes }

      it 'creates an event' do
        expect(json['creator']).to eq(55)
        expect(json['timing']).to eq("2020-09-19T07:03:30.000Z")
        expect(json['where']).to eq('Wash Park')
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/events', params: { creator: 1, where: 'foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"message\":\"Validation failed: Timing can't be blank\"}")
      end
    end
  end

  # Test suite for PUT /api/events/:id
  describe 'PUT /api/events/:id' do
    let(:valid_attributes) { { where: 'Commons Park'} }

    context 'when the record exists' do
      before { put "/api/events/#{event_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/events/:id
  describe 'DELETE /api/events/:id' do
    before { delete "/api/events/#{event_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
