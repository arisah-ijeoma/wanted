module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    # POST /v1/users
    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user, serializer: V1::SessionSerializer, root: nil
      else
        render json: { error: 'Error creating user' }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email,
                                   :full_name,
                                   :address,
                                   :phone_number,
                                   :role,
                                   :password,
                                   :password_confirmation)
    end
  end
end