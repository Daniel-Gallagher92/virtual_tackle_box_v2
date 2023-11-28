class Api::V2::SessionsController < ApplicationController 
  def create 
    user = User.find_by(email: params[:session][:email])

    return render_invalid_response unless user&.authenticate(params[:session][:password])

    session[:user_id] = user.id
    render json: UserSerializer.new(user), status: 200
  end

  private

  def render_invalid_response
    render json: { error: "Invalid credentials"}, status: 401
  end
end