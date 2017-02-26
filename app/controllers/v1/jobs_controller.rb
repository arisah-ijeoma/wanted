module V1
  class JobsController < ApplicationController
    load_and_authorize_resource class: 'Job'

    skip_before_action :authenticate_user_from_token!, only: [:index, :show]
    before_action :get_user

    def index
      @jobs = Job.all
      render json: @jobs, each_serializer: JobsSerializer
    end

    def show
    end

    def create
      @job = @user.jobs.new(job_params)

      if @job.save
        render json: @job, serializer: V1::JobsSerializer
      else
        render json: { error: 'Error creating job' }, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @job.update_attributes(job_params)
        render json: @job, serializer: V1::JobsSerializer
      else
        render json: { error: 'Error updating job' }, status: :unprocessable_entity
      end
    end

    def destroy
      @job.destroy
      head :ok
    end

    private

    def job_params
      params.require(:job).permit(:classification,
                                  :remote,
                                  :duration,
                                  :description,
                                  :user_id)
    end
  end
end
