require "rails_helper"

RSpec.describe "Catch", type: :request do
  describe "PATCH /api/v2/users/:user_id/catches/:id" do
    it "can update a catch w/ valid params" do
      user = create(:user)
      catch = user.catches.create(
        species: "Largemouth Bass",
        weight: 4.4,
        length: 18.5,
        spot_name: "Lake A",
        latitude: 40.7128,
        longitude: -74.0060,
        lure: "Spinnerbait"
      )

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
      patch "/api/v2/users/#{user.id}/catches/#{catch.id}", headers: headers, params: JSON.generate(catch_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      updated_catch = Catch.find(catch.id)
      catch_data = JSON.parse(response.body, symbolize_names: true)

      expect(catch_data).to be_a(Hash)
      expect(catch_data).to have_key(:data)
      expect(catch_data[:data].keys).to eq([:id, :type, :attributes])
      expect(catch_data[:data][:id]).to eq(updated_catch.id.to_s)
      expect(catch_data[:data][:type]).to be_a(String)
      expect(catch_data[:data][:attributes].keys).to eq([:species, :weight, :length, :spot_name, :latitude, :longitude, :lure, :cloudinary_urls])
      expect(catch_data[:data][:attributes][:species]).to eq(updated_catch.species)
      expect(catch_data[:data][:attributes][:weight]).to eq(updated_catch.weight)
      expect(catch_data[:data][:attributes][:length]).to eq(updated_catch.length)
      expect(catch_data[:data][:attributes][:spot_name]).to eq(updated_catch.spot_name)
      expect(catch_data[:data][:attributes][:latitude]).to eq(updated_catch.latitude)
      expect(catch_data[:data][:attributes][:longitude]).to eq(updated_catch.longitude)
      expect(catch_data[:data][:attributes][:lure]).to eq(updated_catch.lure)
    end

    it "cant update catch w/ invalid params" do
      user = create(:user)
      catch = user.catches.create(
        species: "Largemouth Bass",
        weight: 4.4,
        length: 18.5,
        spot_name: "Lake A",
        latitude: 40.7128,
        longitude: -74.0060,
        lure: "Spinnerbait"
      )

      catch_params = {
        "catch": {
          "species": "",
          "weight": 4.5,
          "length": "",
          "spot_name": "Lake D",
          "latitude": 38.9072,
          "longitude": -77.0370,
          "lure": "Topwater"
        }
      }

      headers = { "CONTENT_TYPE" => "application/json" } 
      patch "/api/v2/users/#{user.id}/catches/#{catch.id}", headers: headers, params: JSON.generate(catch_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:error)
      expect(error_data[:error]).to eq("Validation failed: Species can't be blank")
    end
  end
end