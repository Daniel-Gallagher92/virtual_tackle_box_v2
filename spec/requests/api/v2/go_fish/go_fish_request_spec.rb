require "rails_helper"  

RSpec.describe "go_fish", type: :request do
  describe "POST /api/v2/go_fish" do
    it "returns a go_fish object with weather data if given valid credentials" do 
      user = create(:user)

      trip_params = {
        "user_jti": user.jti,
        "origin": "Denver, CO",
        "destination": "39.609475,-106.059580"
      }

      headers = {"CONTENT_TYPE" => "application/json"} 

      post "/api/v2/go_fish", params: JSON.generate(trip_params), headers: headers

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      
      trip_data = JSON.parse(response.body, symbolize_names: true)[:data] 

      expect(trip_data).to have_key(:id)
      expect(trip_data[:id]).to eq("null")
      expect(trip_data).to have_key(:type)
      expect(trip_data[:type]).to eq("go_fish")
      expect(trip_data).to have_key(:attributes)
      expect(trip_data[:attributes]).to have_key(:origin)
      expect(trip_data[:attributes][:origin]).to eq("Denver, CO")
      expect(trip_data[:attributes]).to have_key(:destination)
      expect(trip_data[:attributes][:destination]).to eq("39.609475,-106.059580")
      expect(trip_data[:attributes]).to have_key(:travel_time)
      expect(trip_data[:attributes][:travel_time]).to be_a(String)
      expect(trip_data[:attributes]).to have_key(:forecast)
      expect(trip_data[:attributes][:forecast]).to be_a(Hash)
      expect(trip_data[:attributes][:forecast]).to have_key(:summary)
      expect(trip_data[:attributes][:forecast][:summary]).to be_a(String)
      expect(trip_data[:attributes][:forecast]).to have_key(:datetime)
      expect(trip_data[:attributes][:forecast][:datetime]).to be_a(String)
      expect(trip_data[:attributes][:forecast]).to have_key(:temperature)
      expect(trip_data[:attributes][:forecast][:temperature]).to be_a(Float)
      expect(trip_data[:attributes][:forecast]).to have_key(:feels_like)
      expect(trip_data[:attributes][:forecast][:feels_like]).to be_a(Float)
      expect(trip_data[:attributes][:forecast]).to have_key(:humidity)
      expect(trip_data[:attributes][:forecast][:humidity]).to be_a(Integer)
      expect(trip_data[:attributes][:forecast]).to have_key(:visibility)
      expect(trip_data[:attributes][:forecast][:visibility]).to be_a(Float)
      expect(trip_data[:attributes][:forecast]).to have_key(:uv_index)
      expect(trip_data[:attributes][:forecast][:uv_index]).to be_a(Float)
      expect(trip_data[:attributes][:forecast]).to have_key(:wind_speed)
      expect(trip_data[:attributes][:forecast][:wind_speed]).to be_a(Float)
      expect(trip_data[:attributes][:forecast]).to have_key(:wind_direction)
      expect(trip_data[:attributes][:forecast][:wind_direction]).to be_a(String)
      expect(trip_data[:attributes][:forecast]).to have_key(:pressure)
      expect(trip_data[:attributes][:forecast][:pressure]).to be_a(Float)
      expect(trip_data[:attributes][:forecast]).to have_key(:preciptation)
      expect(trip_data[:attributes][:forecast][:preciptation]).to be_a(Float)
      expect(trip_data[:attributes][:forecast]).to have_key(:cloud_cover)
      expect(trip_data[:attributes][:forecast][:cloud_cover]).to be_a(Integer)
      expect(trip_data[:attributes][:forecast]).to have_key(:icon)
      expect(trip_data[:attributes][:forecast][:icon]).to be_a(String)
    end

    it "returns a 401 error if given invalid credentials" do 
      user = create(:user)

      trip_params = {
        "origin": "Denver, CO",
        "destination": "39.609475,-106.059580",
        "user_jti": "invalid"
      }

      headers = {"CONTENT_TYPE" => "application/json"} 

      post "/api/v2/go_fish", params: JSON.generate(trip_params), headers: headers

      expect(response).to_not be_successful
      expect(response).to have_http_status(:unauthorized)

      unauthorized_data = JSON.parse(response.body, symbolize_names: true)


      expect(User.find_by(jti: trip_params[:user_jti])).to eq(nil)
      expect(User.find_by(jti: user.jti)).to_not eq(nil)
      expect(user.jti).to_not eq(trip_params[:user_jti])

      expect(unauthorized_data).to have_key(:error)
      expect(unauthorized_data[:error]).to eq("Invalid credentials")
      expect(unauthorized_data).to_not have_key(:data)
      expect(unauthorized_data).to_not have_key(:attributes)
      expect(unauthorized_data).to_not have_key(:origin)
      expect(unauthorized_data).to_not have_key(:destination)
      expect(unauthorized_data).to_not have_key(:travel_time)
      expect(unauthorized_data).to_not have_key(:forecast)
      expect(unauthorized_data).to_not have_key(:id)
      expect(unauthorized_data).to_not have_key(:type)
    end
  end
end