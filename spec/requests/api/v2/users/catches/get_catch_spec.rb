require "rails_helper"

RSpec.describe "Catches Index" do 
  describe "/api/v2/users/:user_id/catches" do 
    it "can get all catches for a user" do 
      user = create(:user) 

      catch_1 = user.catches.create(
        species: "Largemouth Bass",
        weight: 3.1,
        length: 13.4,
        spot_name: "Lake A",
        latitude: 40.7128,
        longitude: -74.0060,
        lure: "Spinnerbait"
      )
    
    catch_2 = user.catches.create(
      species: "Walleye",
      weight: 1.1,
      length: 12.1,
      spot_name: "Lake B",
      latitude: 41.8781,
      longitude: -87.6298,
      lure: "Crankbait"
    )
    
    catch_3 = user.catches.create(
      species: "Pike",
      weight: 4.5,
      length: 25.1,
      spot_name: "Lake C",
      latitude: 34.0522,
      longitude: -118.2437,
      lure: "Jerkbait"
    )
      
      headers = { "CONTENT_TYPE" => "application/json" }
      get "/api/v2/users/#{user.id}/catches", headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      catches_data = JSON.parse(response.body, symbolize_names: true)

      expect(catches_data).to be_a(Hash)
      expect(catches_data).to have_key(:data)
      expect(catches_data[:data]).to be_a(Array)
      expect(catches_data[:data].count).to eq(3)
      expect(catches_data[:data][0]).to be_a(Hash)
      expect(catches_data[:data][0]).to have_key(:id)
      expect(catches_data[:data][0][:id]).to be_a(String)
      expect(catches_data[:data][0]).to have_key(:type)
      expect(catches_data[:data][0][:type]).to be_a(String)
      expect(catches_data[:data][0]).to have_key(:attributes)
      expect(catches_data[:data][0][:attributes]).to be_a(Hash)
      expect(catches_data[:data][0][:attributes]).to have_key(:species)
      expect(catches_data[:data][0][:attributes][:species]).to be_a(String)
      expect(catches_data[:data][0][:attributes]).to have_key(:weight)
      expect(catches_data[:data][0][:attributes][:weight]).to be_a(Float)
      expect(catches_data[:data][0][:attributes]).to have_key(:length)
      expect(catches_data[:data][0][:attributes][:length]).to be_a(Float)
      expect(catches_data[:data][0][:attributes]).to have_key(:spot_name)
      expect(catches_data[:data][0][:attributes][:spot_name]).to be_a(String)
      expect(catches_data[:data][0][:attributes]).to have_key(:latitude)
      expect(catches_data[:data][0][:attributes][:latitude]).to be_a(Float)
      expect(catches_data[:data][0][:attributes]).to have_key(:longitude)
      expect(catches_data[:data][0][:attributes][:longitude]).to be_a(Float)
      expect(catches_data[:data][0][:attributes]).to have_key(:lure)
      expect(catches_data[:data][0][:attributes][:lure]).to be_a(String)
    end

    it "cant get catches for a user that doesnt exist" do
      headers = { "CONTENT_TYPE" => "application/json" }
      get "/api/v2/users/1/catches", headers: headers

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:error)
      expect(error_data[:error]).to eq("No User with that ID could be found")
    end

    it "can get a single catch for a user" do
      user = create(:user)

      catch_1 = user.catches.create(
        species: "Largemouth Bass",
        weight: 3.1,
        length: 13.4,
        spot_name: "Lake A",
        latitude: 40.7128,
        longitude: -74.0060,
        lure: "Spinnerbait"
      )
    
    catch_2 = user.catches.create(
      species: "Walleye",
      weight: 1.1,
      length: 12.1,
      spot_name: "Lake B",
      latitude: 41.8781,
      longitude: -87.6298,
      lure: "Crankbait"
    )
    
    catch_3 = user.catches.create(
      species: "Pike",
      weight: 4.5,
      length: 25.1,
      spot_name: "Lake C",
      latitude: 34.0522,
      longitude: -118.2437,
      lure: "Jerkbait"
    )
      
      headers = { "CONTENT_TYPE" => "application/json" }
      get "/api/v2/users/#{user.id}/catches/#{catch_1.id}", headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      catch_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(catch_data).to be_a(Hash)
      expect(catch_data).to have_key(:data)
      expect(catch_data[:data]).to have_key(:id)
      expect(catch_data[:data][:id]).to be_a(String)
      expect(catch_data[:data]).to have_key(:type)
      expect(catch_data[:data][:type]).to be_a(String)
      expect(catch_data[:data]).to have_key(:attributes)
      expect(catch_data[:data][:attributes]).to be_a(Hash)
      expect(catch_data[:data][:attributes].keys).to eq([:species, :weight, :length, :spot_name, :latitude, :longitude, :lure, :cloudinary_urls])
      expect(catch_data[:data][:attributes][:species]).to be_a(String)
      expect(catch_data[:data][:attributes][:weight]).to be_a(Float)
      expect(catch_data[:data][:attributes][:length]).to be_a(Float)
      expect(catch_data[:data][:attributes][:spot_name]).to be_a(String)
      expect(catch_data[:data][:attributes][:latitude]).to be_a(Float)
      expect(catch_data[:data][:attributes][:longitude]).to be_a(Float)
      expect(catch_data[:data][:attributes][:lure]).to be_a(String)
    end

    it "cant get single catch for user that does not exist" do
      headers = { "CONTENT_TYPE" => "application/json" }
      get "/api/v2/users/1/catches/1", headers: headers


      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:error)
      expect(error_data[:error]).to eq("No User with that ID could be found")
    end

    
    it "cant get a catch that does not exist" do
      user = create(:user)
      
      headers = { "CONTENT_TYPE" => "application/json" }
      get "/api/v2/users/#{user.id}/catches/1"
      
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:error)
      expect(error_data[:error]).to eq("No Catch with that ID could be found")
    end
  end
end