require 'rails_helper'

describe V1::SessionsController do
  describe 'POST#create' do
    let(:user) { create(:user) }

    describe 'successful login' do
      it 'returns the user access token' do

        user_params = {
            'user' => {
                'email' => user.email,
                'password' => user.password
            }
        }

        post :create, params: user_params

        json = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(json['access_token']).to eq(user.access_token)
      end
    end

    describe 'unsuccessful login' do
      it 'returns the error' do

        user_params = {
            'user' => {
                'email' => user.email,
                'password' => 'user.password'
            }
        }

        post :create, params: user_params

        expect(response.status).to eq(422)
      end
    end
  end
end
