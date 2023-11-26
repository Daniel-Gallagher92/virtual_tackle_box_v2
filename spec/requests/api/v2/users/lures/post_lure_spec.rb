require "rails_helper"

RSpec.describe "Lures", type: :request do 
  describe "POST /api/v2/users/:user_id/lures" do 
    it "can create a lure w/ valid params" do 
      user = create(:user)

      params = {
        "lure": {
          "brand": "Rapala",
          "variety": "Popper",
          "color": "Orange/White",
          "weight": 1.5,
        }
      }
      
      headers = { "CONTENT_TYPE" => "application/json" } 
      post "/api/v2/users/#{user.id}/lures", headers: headers, params: JSON.generate(params)
      
      expect(response).to be_successful
      expect(response.status).to eq(201)
      
      new_lure = Lure.last
      lure_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(lure_data).to be_a(Hash)
      expect(lure_data).to have_key(:data)
      expect(lure_data[:data]).to be_a(Hash)
      expect(lure_data[:data]).to have_key(:id)
      expect(lure_data[:data][:id]).to eq(new_lure.id.to_s)
      expect(lure_data[:data]).to have_key(:type)
      expect(lure_data[:data][:type]).to eq("lure")
      expect(lure_data[:data]).to have_key(:attributes)
      expect(lure_data[:data][:attributes]).to be_a(Hash)
      expect(lure_data[:data][:attributes]).to have_key(:brand)
      expect(lure_data[:data][:attributes][:brand]).to eq(new_lure.brand)
      expect(lure_data[:data][:attributes]).to have_key(:variety)
      expect(lure_data[:data][:attributes][:variety]).to eq(new_lure.variety)
      expect(lure_data[:data][:attributes]).to have_key(:color)
      expect(lure_data[:data][:attributes][:color]).to eq(new_lure.color)
      expect(lure_data[:data][:attributes]).to have_key(:weight)
      expect(lure_data[:data][:attributes][:weight]).to eq(new_lure.weight)
    end

    it "cannot create a lure w/ invalid params" do 
      user = create(:user)

      params = {
        "lure": {
          "brand": "",
          "variety": "",
          "color": "Orange/White",
          "weight": 1.5,
        }
      }
      
      headers = { "CONTENT_TYPE" => "application/json" } 
      post "/api/v2/users/#{user.id}/lures", headers: headers, params: JSON.generate(params)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:error)
      expect(error_data[:error]).to eq("Validation failed: Brand can't be blank, Variety can't be blank")
    end
  end
end