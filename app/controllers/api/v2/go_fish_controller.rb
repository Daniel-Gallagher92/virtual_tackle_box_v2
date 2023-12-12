class Api::V2::GoFishController < ApplicationController 

  def create
    user = User.find_by(jti: params[:user_jti])

    if user
      trip = GoFishFacade.get_new_road_trip(params[:origin], params[:destination])
      render json: GoFishSerializer.new(trip)
    else
      render json: {error: "Invalid credentials"}, status: :unauthorized
    end
  end

end