class Api::V2::CatchesController < ApplicationController 
  before_action :set_user
  before_action :set_catch, only: [:show, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

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

  def index 
    catches = @user.catches.all
    render json: CatchSerializer.new(catches), status: 200 
  end

  def show 
    render json: CatchSerializer.new(@catch), status: 200
  end

  def update
    if params[:cloudinary_urls]
      @catch.cloudinary_urls = params[:cloudinary_urls]
    end
    if @catch.update(catch_params)
      render json: CatchSerializer.new(@catch), status: 200
    else
      render json: { error: "Validation failed: #{@catch.errors.full_messages.join(", ")}" }, status: 422
    end
  end

  def destroy 
    @catch.destroy
    render json: { message: "Catch successfully deleted" }, status: 200
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

  def record_not_found(error) 
    model_name = error.message.split(" ")[2..2].join(" ").gsub(/#/, '').singularize
    render json: { error: "No #{model_name} with that ID could be found" }, status: :not_found
  end

  def purge_photos(ids_to_delete)
    photo_ids = ids_to_delete.split(",").map(&:to_i)
    purged_photos = []
    errors = []
  
    photo_ids.each do |id|
      begin
        photo = @catch.photos.find(id)
        photo.purge_later
        purged_photos << id
      rescue ActiveRecord::RecordNotFound => e
        errors << "Photo with ID #{id} could not be found"
      end
    end
  end
end