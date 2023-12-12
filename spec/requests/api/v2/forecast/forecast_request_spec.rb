require "rails_helper"

RSpec.describe "Forecast Request" do 
  it "can return JSON data for a city's forecast" do 

    headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
    get "/api/v2/forecasts", headers: headers, params: {location: "Denver,Co"}
    forecast = JSON.parse(response.body, symbolize_names: true)

    #test for response status and data type
    expect(response).to be_successful 
    expect(response.status).to eq(200)
    expect(forecast).to be_a Hash

    #test for keys that should be present in forecast
    expect(forecast).to have_key :data
    expect(forecast[:data]).to be_a Hash
    expect(forecast[:data]).to have_key :id
    expect(forecast[:data][:id]).to eq(nil)
    expect(forecast[:data]).to have_key :type
    expect(forecast[:data][:type]).to eq("forecast")
    expect(forecast[:data]).to have_key :attributes
    expect(forecast[:data][:attributes]).to be_a Hash
    expect(forecast[:data][:attributes]).to have_key :current_weather

    #test for attributes that should be present in current_weather  
    expect(forecast[:data][:attributes][:current_weather]).to be_a Hash
    expect(forecast[:data][:attributes][:current_weather]).to have_key :last_updated
    expect(forecast[:data][:attributes][:current_weather][:last_updated]).to be_a String
    expect(forecast[:data][:attributes][:current_weather]).to have_key :temp_f
    expect(forecast[:data][:attributes][:current_weather][:temp_f]).to be_a Float
    expect(forecast[:data][:attributes][:current_weather]).to have_key :feelslike_f
    expect(forecast[:data][:attributes][:current_weather][:feelslike_f]).to be_a Float
    expect(forecast[:data][:attributes][:current_weather]).to have_key :humidity
    expect(forecast[:data][:attributes][:current_weather][:humidity]).to be_a Integer
    expect(forecast[:data][:attributes][:current_weather]).to have_key :uv
    expect(forecast[:data][:attributes][:current_weather][:uv]).to be_a Float
    expect(forecast[:data][:attributes][:current_weather]).to have_key :visibilty
    expect(forecast[:data][:attributes][:current_weather][:visibilty]).to be_a Float
    expect(forecast[:data][:attributes][:current_weather]).to have_key :condition_text
    expect(forecast[:data][:attributes][:current_weather][:condition_text]).to be_a String
    expect(forecast[:data][:attributes][:current_weather]).to have_key :condition_icon
    expect(forecast[:data][:attributes][:current_weather][:condition_icon]).to be_a String
    
    #test for attributes that should not be present in current_weather  
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :precipitation_in
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :precipitation_probability
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :max_temp_c
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :min_temp_c
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :max_wind_speed_mph
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :max_wind_speed_kmh  
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :max_wind_speed_kts
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :max_wind_speed_ms
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :total_precip_mm
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :total_precip_in
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :avg_temp_f
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :avg_temp_c
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :max_wind_speed
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :total_precip
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :avg_vis_km
    expect(forecast[:data][:attributes][:current_weather]).to_not have_key :avg_vis_miles


    #test for attributes that should be present in daily_weather
    expect(forecast[:data][:attributes]).to have_key :daily_weather
    expect(forecast[:data][:attributes][:daily_weather]).to be_a Array
    expect(forecast[:data][:attributes][:daily_weather].count).to eq(3)
    expect(forecast[:data][:attributes][:daily_weather].first).to be_a Hash
    expect(forecast[:data][:attributes][:daily_weather].first).to have_key :date
    expect(forecast[:data][:attributes][:daily_weather].first[:date]).to be_a String
    expect(forecast[:data][:attributes][:daily_weather].first).to have_key :max_temp_f
    expect(forecast[:data][:attributes][:daily_weather].first[:max_temp_f]).to be_a Float
    expect(forecast[:data][:attributes][:daily_weather].first).to have_key :min_temp_f
    expect(forecast[:data][:attributes][:daily_weather].first[:min_temp_f]).to be_a Float
    expect(forecast[:data][:attributes][:daily_weather].first).to have_key :sunrise
    expect(forecast[:data][:attributes][:daily_weather].first[:sunrise]).to be_a String
    expect(forecast[:data][:attributes][:daily_weather].first).to have_key :sunset
    expect(forecast[:data][:attributes][:daily_weather].first[:sunset]).to be_a String
    expect(forecast[:data][:attributes][:daily_weather].first).to have_key :condition_text
    expect(forecast[:data][:attributes][:daily_weather].first[:condition_text]).to be_a String
    expect(forecast[:data][:attributes][:daily_weather].first).to have_key :condition_icon
    expect(forecast[:data][:attributes][:daily_weather].first[:condition_icon]).to be_a String


    
    #test for attributes that should not be present in daily_weather  
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :precipitation
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :precipitation_in
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :precipitation_probability
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :max_temp_c
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :min_temp_c
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :max_wind_speed_mph
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :max_wind_speed_kmh  
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :max_wind_speed_kts
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :max_wind_speed_ms
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :total_precip_mm
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :total_precip_in
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :avg_temp_f
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :avg_temp_c
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :max_wind_speed
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :total_precip
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :avg_vis_km
    expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key :avg_vis_miles

    #test for attributes that should be present in hourly_weather
    expect(forecast[:data][:attributes]).to have_key :hourly_weather
    expect(forecast[:data][:attributes][:hourly_weather]).to be_a Array
    expect(forecast[:data][:attributes][:hourly_weather].count).to eq(24)
    expect(forecast[:data][:attributes][:hourly_weather].first).to be_a Hash
    expect(forecast[:data][:attributes][:hourly_weather].first).to have_key :time
    expect(forecast[:data][:attributes][:hourly_weather].first[:time]).to be_a String
    expect(forecast[:data][:attributes][:hourly_weather].first).to have_key :temp_f
    expect(forecast[:data][:attributes][:hourly_weather].first[:temp_f]).to be_a Float
    expect(forecast[:data][:attributes][:hourly_weather].first).to have_key :condition_text
    expect(forecast[:data][:attributes][:hourly_weather].first[:condition_text]).to be_a String
    expect(forecast[:data][:attributes][:hourly_weather].first).to have_key :condition_icon
    expect(forecast[:data][:attributes][:hourly_weather].first[:condition_icon]).to be_a String

    #test for attributes that should not be present in hourly_weather
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :precipitation
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :precipitation_in
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :precipitation_probability
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :max_temp_c
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :min_temp_c
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :max_wind_speed_mph
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :max_wind_speed_kmh  
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :max_wind_speed_kts
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :max_wind_speed_ms
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :total_precip_mm
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :total_precip_in
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :avg_temp_f
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :avg_temp_c
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :max_wind_speed
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :total_precip
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :avg_vis_km
    expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key :avg_vis_miles
  end

  it "returns an error if no location is provided" do 
    headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
    get "/api/v2/forecasts", headers: headers, params: {location: ""}
    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)
    
    parsed_error = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_error).to have_key :error
    expect(parsed_error[:error]).to eq("Location is required")
  end
end