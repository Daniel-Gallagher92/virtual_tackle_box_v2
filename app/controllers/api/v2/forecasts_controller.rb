class Api::V2::ForecastsController < ApplicationController 
  def index
    if params[:location].blank?
      render json: { error: 'Location is required' }, status: :bad_request
    else
      forecast = ForecastFacade.get_forecast(params[:location])
      render json: ForecastSerializer.new(forecast)
    end
  end

  def show
    if params[:location].blank?
      render json: { error: 'Location is required' }, status: :bad_request
    else
      forecast = ForecastFacade.get_forecast(params[:location])
      render json: ForecastSerializer.new(forecast)
    end
  end
end
