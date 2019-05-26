require 'rails_helper'

RSpec.describe 'user_events API', type: :request do
  #initialize test data
  before(:each) do
    @event = Event.create(creator: 55, timing: "2020-09-19 07:03:30", where: 'Wash Park')
    @user = User.create(name: "Tim Duncan", email: "tim@duncan.com", password: 'mypassword')
    user_event = UserEvent.create(user: @user, event: @event)
    @user_event_id = user_event.id
  end

  # Test suite for POST /api/events
  describe 'POST /api/user_events' do
    # valid creation data

    context 'when the request is valid' do
      before { post '/api/user_events', params: { user_id: @user.id, event_id: @event.id } }

      it 'creates a user_event' do
        expect(json['user_id']).to eq(1)
        expect(json['event_id']).to eq(1)
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/user_events', params: { user_id: @user.id } }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"message\":\"Couldn't find Event without an ID\"}")
      end
    end
  end


  # Test suite for DELETE /api/user_events/:id
  describe 'DELETE /api/events/:id' do
    before { delete "/api/user_events/#{@user_event_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end


end
