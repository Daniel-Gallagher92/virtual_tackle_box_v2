class Api::V2::LuresController < ApplicationController 
  before_action :set_user
  before_action :set_lure, only: [:update, :show]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def create 
    @lure = @user.lures.build(lure_params)
    begin 
      @lure.save!
      render json: LureSerializer.new(@lure), status: 201
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    end
  end

  def index 
    render json: LureSerializer.new(@user.lures), status: 200
  end

  def show 
    render json: LureSerializer.new(@lure), status: 200
  end

  def update 
    begin 
      @lure.update!(lure_params)
      render json: LureSerializer.new(@lure), status: 200
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    end
  end

  def destroy 
    @lure = @user.lures.find(params[:id])
    @lure.destroy
    render json: { message: "Lure successfully deleted"}, status: 200
  end

  private

  def set_user 
    @user = User.find(params[:user_id])
  end

  def set_lure 
    @lure = @user.lures.find(params[:id])
  end

  def lure_params 
    params.require(:lure).permit(:brand, :variety, :color, :weight)
  end

  def record_not_found(error) 
    model_name = error.message.split(" ")[2..2].join(" ").gsub(/#/, '').singularize
  
    render json: { error: "No #{model_name} with that ID could be found" }, status: :not_found
  end
end