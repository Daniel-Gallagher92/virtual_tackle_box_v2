require "rails_helper"

RSpec.describe "Catches", type: :request do
  describe "POST /api/v2/users/:user_id/catches" do
    it "can create a catch with valid params" do
      user = create(:user)

      catch_params = {
        "catch": {
          "species": "Pike",
          "weight": 4.5,
          "length": 29.1,
          "spot_name": "Lake D",
          "latitude": 38.9072,
          "longitude": -77.0370,
          "lure": "Topwater"
        }
      }

      headers = { "CONTENT_TYPE" => "application/json" }
      post "/api/v2/users/#{user.id}/catches", headers: headers, params: JSON.generate(catch_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      new_catch = Catch.last
      catch_data = JSON.parse(response.body, symbolize_names: true)

      expect(catch_data).to be_a(Hash)
      expect(catch_data).to have_key(:data)
      expect(catch_data[:data].keys).to eq([:id, :type, :attributes])
      expect(catch_data[:data][:id]).to eq(new_catch.id.to_s)
      expect(catch_data[:data][:type]).to be_a(String)
      expect(catch_data[:data][:attributes].keys).to eq([:species, :weight, :length, :spot_name, :latitude, :longitude, :lure, :cloudinary_urls])
      expect(catch_data[:data][:attributes][:species]).to eq(new_catch.species)
      expect(catch_data[:data][:attributes][:weight]).to eq(new_catch.weight)
      expect(catch_data[:data][:attributes][:length]).to eq(new_catch.length)
      expect(catch_data[:data][:attributes][:spot_name]).to eq(new_catch.spot_name)
      expect(catch_data[:data][:attributes][:latitude]).to eq(new_catch.latitude)
      expect(catch_data[:data][:attributes][:longitude]).to eq(new_catch.longitude)
      expect(catch_data[:data][:attributes][:lure]).to eq(new_catch.lure)

    end

    it "can't create a catch with invalid params" do
      user = create(:user)

      catch_params = {
        "catch": {
          "species": "",
          "weight": "",
          "length": 29.1,
          "spot_name": "Lake D",
          "latitude": 38.9072,
          "longitude": -77.0370,
          "lure": "Topwater"
        }
      }

      headers = { "CONTENT_TYPE" => "application/json" } 
      post "/api/v2/users/#{user.id}/catches", headers: headers, params: JSON.generate(catch_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:error)
      expect(error_data[:error]).to include("Validation failed: Species can't be blank")
    end
  end
end