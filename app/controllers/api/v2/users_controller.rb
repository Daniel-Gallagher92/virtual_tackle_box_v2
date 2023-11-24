class Api::V2::UsersController < ApplicationController 
  def create 
    @user = User.create(user_params)

    begin 
      @user.save!
      render json: UserSerializer.new(@user), status: 201
    rescue ActiveRecord::RecordInvalid => e 
      render json: { error: e.message }, status: 422
    end
  end

  private 

  def user_params 
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end