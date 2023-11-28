class Api::V2::SessionsController < ApplicationController 
  def create 
    user = User.find_by(email: params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      render json: UserSerializer.new(user), status: 200
    else
      render_invalid_response
    end
  end

  private

  def render_invalid_response
    render json: { error: "Invalid credentials"}, status: 400
  end
end