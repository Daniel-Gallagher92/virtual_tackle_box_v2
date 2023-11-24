class Api::V2::CatchesController < ApplicationController 
  before_action :set_user
  
  def create 
    @catch = @user.catches.build(catch_params)
    @catch.cloudinary_urls = params[:cloudinary_urls] if params[:cloudinary_urls]
    begin 
      @catch.save!
      render json: CatchSerializer.new(@catch), status: 201 
    rescue ActiveRecord::RecordInvalid => e 
      render json: { error: e.message }, status: 422
    end
  end

  private

  def set_user 
    @user = User.find(params[:user_id])
  end

  def set_catch 
    @catch = @user.catches.find(params[:id])
  end

  def catch_params 
    params.require(:catch).permit(:species, :weight, :length, :spot_name, :latitude, :longitude, :lure, cloudinary_urls: [])
  end
end