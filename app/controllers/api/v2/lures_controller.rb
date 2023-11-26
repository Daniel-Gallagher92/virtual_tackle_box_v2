class Api::V2::LuresController < ApplicationController 
  before_action :set_user

  def create 
    @lure = @user.lures.build(lure_params)
    begin 
      @lure.save!
      render json: LureSerializer.new(@lure), status: 201
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    end
  end

  private

  def set_user 
    @user = User.find(params[:user_id])
  end

  def lure_params 
    params.require(:lure).permit(:brand, :variety, :color, :weight)
  end
end