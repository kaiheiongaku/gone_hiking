require 'rails_helper'

describe 'searches requests' do
  describe 'post request for searches' do
    describe 'happy path' do
      before :each do
        user1 = User.create!(email: 'me@me.com', password: 'pass', password_confirmation: 'pass')
      end

      it 'creates a search' do
        headers = { 'ACCEPT' => 'application/json' }
        params = { "search": {
                  "text": "pa",
                  "user": "user1"
                  }
                }
        post '/api/v1/searches', params: params, headers: headers

        expect(response.content_type).to eq('application/json')
        expect(response.status).to eq(201)

        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(parsed).to be_a(Hash)
        expect(parsed).to have_key(:data)
        expect(parsed[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed[:data][:attributes].keys).to eq([:text, :user])

        expect(Search.last.text).to eq('pa')
        expect(Search.last.user).to eq(user1)
      end
    end
  end

  # describe 'get requests for all searches' do
  #   describe 'happy path' do
  #     it 'can return all searches for all users' do
  #       get 'api/v1/searches'
  #     end
  #
  #     it 'can return all searches for a particular user' do
  #       get "api/v1/users/#{user1.id}/searches"
  #
  #     end
  #   end

    describe 'sad path' do
      it 'returns an error if the wrong url is used' do

      end

      it 'returns an error if the user does not exist' do

      # end
    end
  end
end
