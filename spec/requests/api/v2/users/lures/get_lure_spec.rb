require "rails_helper"

RSpec.describe "Lures Index", type: :request do 
  describe "GET /api/v2/users/:user_id/lures" do
    it "can get all lures for a user" do 
      user = create(:user)
      lure_1 = user.lures.create(brand: "Rapala", variety: "Popper", color: "Orange/White", weight: 1.5)
      lure_2 = user.lures.create(brand: "Nature", variety: "Live Bait", color: "Grey", weight: 2.1)
      lure_3 = user.lures.create(brand: "Rapala", variety: "Spinner", color: "Blue/White", weight: 1.025)

      headers = { "CONTENT_TYPE" => "application/json" }
      get "/api/v2/users/#{user.id}/lures", headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      lure_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(lure_data).to be_a(Hash)
      expect(lure_data).to have_key(:data)
      expect(lure_data[:data]).to be_a(Array)
      expect(lure_data[:data].count).to eq(3)
      expect(lure_data[:data][0]).to be_a(Hash)
      expect(lure_data[:data][0]).to have_key(:id)
      expect(lure_data[:data][0][:id]).to be_a(String)
      expect(lure_data[:data][0]).to have_key(:type)
      expect(lure_data[:data][0][:type]).to be_a(String)
      expect(lure_data[:data][0]).to have_key(:attributes)
      expect(lure_data[:data][0][:attributes]).to be_a(Hash)
      expect(lure_data[:data][0][:attributes]).to have_key(:brand)
      expect(lure_data[:data][0][:attributes][:brand]).to be_a(String)
      expect(lure_data[:data][0][:attributes]).to have_key(:variety)
      expect(lure_data[:data][0][:attributes][:variety]).to be_a(String)
      expect(lure_data[:data][0][:attributes]).to have_key(:color)
      expect(lure_data[:data][0][:attributes][:color]).to be_a(String)
      expect(lure_data[:data][0][:attributes]).to have_key(:weight)
      expect(lure_data[:data][0][:attributes][:weight]).to be_a(Float)
    end

    it "cannot get lures for a user that does not exist" do 
      headers = { "CONTENT_TYPE" => "application/json" }
      get "/api/v2/users/1/lures", headers: headers

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:error)
      expect(error_data[:error]).to eq("No User with that ID could be found")
    end

    it "can get a single lure for a user" do 
      user = create(:user)
      lure_1 = user.lures.create(brand: "Rapala", variety: "Popper", color: "Orange/White", weight: 1.5)
      lure_2 = user.lures.create(brand: "Nature", variety: "Live Bait", color: "Grey", weight: 2.1)
      lure_3 = user.lures.create(brand: "Rapala", variety: "Spinner", color: "Blue/White", weight: 1.025)

      headers = { "CONTENT_TYPE" => "application/json" }
      get "/api/v2/users/#{user.id}/lures/#{lure_1.id}", headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      lure_data = JSON.parse(response.body, symbolize_names: true)

      expect(lure_data).to be_a(Hash)
      expect(lure_data).to have_key(:data)
      expect(lure_data[:data]).to be_a(Hash)
      expect(lure_data[:data]).to have_key(:id)
      expect(lure_data[:data][:id]).to be_a(String)
      expect(lure_data[:data]).to have_key(:type)
      expect(lure_data[:data][:type]).to be_a(String)
      expect(lure_data[:data]).to have_key(:attributes)
      expect(lure_data[:data][:attributes]).to be_a(Hash)
      expect(lure_data[:data][:attributes]).to have_key(:brand)
      expect(lure_data[:data][:attributes][:brand]).to be_a(String)
      expect(lure_data[:data][:attributes]).to have_key(:variety)
      expect(lure_data[:data][:attributes][:variety]).to be_a(String)
      expect(lure_data[:data][:attributes]).to have_key(:color)
      expect(lure_data[:data][:attributes][:color]).to be_a(String)
      expect(lure_data[:data][:attributes]).to have_key(:weight)
      expect(lure_data[:data][:attributes][:weight]).to be_a(Float)
    end

    it "cannot get a single lure for a user that does not exist" do 
      headers = { "CONTENT_TYPE" => "application/json" }
      get "/api/v2/users/1/lures/1", headers: headers

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:error)
      expect(error_data[:error]).to eq("No User with that ID could be found")
    end

    it "cannot get a single lure for a lure that does not exist" do 
      user = create(:user)

      headers = { "CONTENT_TYPE" => "application/json" }
      get "/api/v2/users/#{user.id}/lures/1", headers: headers

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:error)
      expect(error_data[:error]).to eq("No Lure with that ID could be found")
    end
  end
end