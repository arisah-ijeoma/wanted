require 'rails_helper'

describe V1::JobsController do
  let(:user) { create(:user) }
  let(:fishy_user) { create(:user, full_name: 'Reverse Flash') }
  let(:job) { create(:job, user_id: user.id) }
  let(:job_params) { {
      'job' => {
          'classification' => job.classification,
          'duration' => job.duration,
          'description' => job.description,
          'user_id' => job.user_id
      }
  } }
  let(:invalid_job_params) { {
      'job' => {
          'classification' => '',
          'duration' => job.duration,
          'description' => job.description,
          'user_id' => job.user_id
      }
  } }

  let(:job_params_with_invalid_user) { {
      'job' => {
          'classification' => '',
          'duration' => job.duration,
          'description' => job.description,
          'user_id' => fishy_user.id
      }
  } }

  before do
    login user
  end

  describe 'GET#index' do
    it 'returns ok status' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET#show' do
    it 'returns ok status' do
      get :show, id: job
      expect(response.status).to eq(200)
    end
  end

  describe 'POST#create' do
    it 'returns ok status' do
      post :create, job_params
      expect(response.status).to eq(200)
    end

    it 'fails with invalid params' do
      post :create, invalid_job_params
      expect(response.status).to eq(422)
    end
  end

  describe 'GET#edit' do
    it 'returns ok status' do
      get :edit, id: job
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT#update' do
    it 'returns ok status' do
      put :update, { id: job, job: attributes_for(:job) }
      expect(response.status).to eq(200)
    end

    it 'fails with invalid params' do
      put :update, { id: job, job: attributes_for(:invalid_job) }
      expect(response.status).to eq(422)
    end

    it 'returns unauthorized when user is not the owner of the job' do
      login fishy_user
      put :update, { id: job, 'job' => {
                             'classification' => job.classification,
                             'duration' => job.duration,
                             'description' => job.description,
                             'user_id' => fishy_user.id
                             }
                 }
      expect(response.status).to eq(403)
    end
  end

  describe 'DELETE#destroy' do
    it 'returns ok status' do
      delete :destroy, id: job
      expect(response.status).to eq(200)
      expect(Job.exists?(job.id)).to be false
    end
  end
end
