require 'rails_helper'

describe 'users requests' do
  describe 'post request for user' do
    describe 'happy path' do
      it 'creates a user' do
        headers = { 'ACCEPT' => 'application/json' }
        params = { "user": {
                  "email": "whatever@example.com",
                  "password": "password",
                  "password_confirmation": "password"}
                }
        post '/api/v1/users', params: params, headers: headers

        expect(response.content_type).to eq('application/json')
        expect(response.status).to eq(201)

        parsed = JSON.parse(response.body, symbolize_names: true)
        expect(parsed).to be_a(Hash)
        expect(parsed).to have_key(:data)
        expect(parsed[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed[:data][:attributes].keys).to eq([:email, :api_key])

        expect(User.last.email).to eq('whatever@example.com')
        expect(User.last.api_key.size).to eq(22)
      end
    end

    describe 'sad path' do
      it 'returns an error if the params do not have an email' do
        headers = { 'ACCEPT' => 'application/json' }
        params = { "user": {
                  "password": "password",
                  "password_confirmation": "password"}
                }
        post '/api/v1/users', params: params, headers: headers

        expect(response.status).to eq(400)

        errors = JSON.parse(response.body, symbolize_names: true)[:errors]
        expect(errors).to eq(["Email can't be blank"])
      end

      it 'returns an error if there is no password' do
        headers = { 'ACCEPT' => 'application/json' }
        params = { "user": {
                  "email": "whatever@example.com",
                  "password_confirmation": "password"}
                }
        post '/api/v1/users', params: params, headers: headers

        expect(response.status).to eq(400)

        errors = JSON.parse(response.body, symbolize_names: true)[:errors]
        expect(errors).to eq(["Password can't be blank"])
      end

      it 'returns an error if there is no password confirmation' do
        headers = { 'ACCEPT' => 'application/json' }
        params = { "user": {
                  "email": "whatever@example.com",
                  "password": "password" }
                }
        post '/api/v1/users', params: params, headers: headers

        expect(response.status).to eq(400)

        errors = JSON.parse(response.body, symbolize_names: true)[:errors]
        expect(errors).to eq('Missing password confirmation.')
      end

      it 'ignores extra params' do
        headers = { 'ACCEPT' => 'application/json' }
        params = { "user": {
                  "email": "whatever@example.com",
                  "password": "password",
                  "password_confirmation": "password",
                'iamanextraparam': 'extra'}
                }
        post '/api/v1/users', params: params, headers: headers

        expect(response.status).to eq(201)
      end

      it 'returns an error if the passwords do not match' do
        headers = { 'ACCEPT' => 'application/json' }
        params = { "user": {
                  "email": "whatever@example.com",
                  "password": "password",
                  "password_confirmation": "notTheSame"}
                }
        post '/api/v1/users', params: params, headers: headers

        expect(response.status).to eq(400)

        errors = JSON.parse(response.body, symbolize_names: true)[:errors]
        expect(errors).to eq(["Password confirmation doesn't match Password"])
      end

      it 'returns an error if the email is already taken' do
        User.create!(email: "whatever@example.com", password: 'IanisAwesome')
        headers = { 'ACCEPT' => 'application/json' }
        params = { "user": {
                  "email": "whatever@example.com",
                  "password": "password",
                  "password_confirmation": "password"}
                }
        post '/api/v1/users', params: params, headers: headers

        expect(response.status).to eq(400)

        errors = JSON.parse(response.body, symbolize_names: true)[:errors]
        expect(errors).to eq(['Email has already been taken'])
      end
    end
  end
end
