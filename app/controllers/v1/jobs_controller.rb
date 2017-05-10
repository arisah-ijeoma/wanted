module V1
  class JobsController < ApplicationController
    load_and_authorize_resource class: 'Job'

    skip_before_action :authenticate_user_from_token!, only: [:index, :show]
    before_action :get_user

    def index
      all_jobs = Job.all
      decorated_jobs = JobDecorator.new(all_jobs)
      jobs = decorated_jobs.get_by_request(params[:q],
                                           params[:type],
                                           params[:remote],
                                           params[:min],
                                           params[:max])
      render json: jobs, each_serializer: V1::JobsSerializer
    end

    def show
      if @job
        render json: @job, serializer: V1::JobsSerializer
      else
        render status: 404
      end
    end

    def create
      job = @user.jobs.new(job_params)

      if job.save
        render json: job, serializer: V1::JobsSerializer
      else
        render json: { error: 'Error creating job' }, status: :unprocessable_entity
      end
    end

    def update
      if @job.update_attributes(job_params)
        render json: @job, serializer: V1::JobsSerializer
      else
        render json: { error: 'Error updating job' }, status: :unprocessable_entity
      end
    end

    def apply
      # apply feature will be implemented
      if @user.confirmed_at.present?
        render json: { message: 'This person can apply' }, status: :ok
      else
        render json: { message: 'Confirm your email' }, statue: :unprocessable_entity
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
                                  :title,
                                  :amount,
                                  :description,
                                  :user_id)
    end
  end
end
