require 'rails_helper'

describe V1::UsersController do

  describe 'POST#create' do

    it 'returns invalid status for invalid details' do
      post :create, params: { user: attributes_for(:invalid_user) }
      expect(response.status).to eq(422)
    end

    it 'returns ok status for valid details' do
      post :create, params: { user: attributes_for(:user) }
      expect(response.status).to eq(200)
    end
  end
end
