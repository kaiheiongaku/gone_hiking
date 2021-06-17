require 'rails_helper'

describe 'searches requests' do
  before :each do
    @user1 = User.create!(email: 'me@me.com', password: 'pass', password_confirmation: 'pass')
  end

  describe 'post request for searches' do
    describe 'happy path' do

      it 'creates a search' do
        headers = { 'ACCEPT' => 'application/json' }
        params = { "search": {
                  "text": "pa",
                  "user": @user1.id
                  }
                }
        post '/api/v1/searches', params: params, headers: headers

        expect(response.content_type).to eq('application/json')
        expect(response.status).to eq(201)

        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(parsed).to be_a(Hash)
        expect(parsed).to have_key(:data)
        expect(parsed[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed[:data][:attributes].keys).to eq([:text, :user_id])
        expect(parsed[:data][:attributes][:text]).to eq('pa')
        expect(parsed[:data][:attributes][:user_id]).to eq(@user1.id)

        expect(Search.last.text).to eq('pa')
        expect(Search.last.user.id).to eq(@user1.id)
      end
    end

    describe 'sad path' do
      it 'returns an error if user_id does not exist' do
        headers = { 'ACCEPT' => 'application/json' }
        params = { "search": {
                  "text": "pa",
                  "user": 1089
                  }
                }
        post '/api/v1/searches', params: params, headers: headers

        expect(response.status).to eq(400)

        errors = JSON.parse(response.body, symbolize_names: true)[:errors]
        expect(errors).to eq(["User must exist", "User can't be blank"])
      end

      it 'returns an error if user is not supplied' do
        headers = { 'ACCEPT' => 'application/json' }
        params = { "search": {
                  "text": "pa"
                  }
                }
        post '/api/v1/searches', params: params, headers: headers

        expect(response.status).to eq(400)

        errors = JSON.parse(response.body, symbolize_names: true)[:errors]
        expect(errors).to eq(["User must exist", "User can't be blank"])
      end

      it 'returns an error if text is not supplied' do
        headers = { 'ACCEPT' => 'application/json' }
        params = { "search": {
                  "user": @user1.id
                  }
                }
        post '/api/v1/searches', params: params, headers: headers

        expect(response.status).to eq(400)

        errors = JSON.parse(response.body, symbolize_names: true)[:errors]
        expect(errors).to eq(["Text can't be blank"])
      end

#       it 'returns an error if text is not unique for that user' do
#
#       end
#
#       it 'returns an error if the wrong url is used' do
#
#       end
#     end
#   end
#
#   describe 'all searches for a particular user' do
#     describe 'happy path' do
#       it 'can return all searches for a particular user' do
#             get "api/v1/users/#{user1.id}/searches"
#
#       end
#     end
#
#     describe 'sad path' do
#       it 'returns an error if user does not exist' do
#
#       end
#
#       it 'returns an error if wrong url is used' do
#
#       end
#     end
#
#     describe 'returns all searches for all users' do
#       describe 'happy path' do
#         it 'returns all searches for all users' do
#
#         end
#       end
#
#       describe 'sad path' do
#         it 'returns an error if wrong url is used' do
#
#         end
#       end
#     end
#   end
#
#     describe 'sad path' do
#       it 'returns an error if the wrong url is used' do
#
#       end
#
#       it 'returns an error if the user does not exist' do
#
#       end
    end
  end
end
