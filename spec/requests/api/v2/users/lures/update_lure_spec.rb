require "rails_helper" 

RSpec.describe "Lures", type: :request do 
  describe "PATCH /api/v2/users/:user_id/lures/:id" do 
    it "can update a lure w/ valid params" do 
      user = create(:user)
      lure = user.lures.create(brand: "Rapala", variety: "Popper", color: "Orange/White", weight: 1.5)

      params = {
        "lure": {
          "brand": "Rapala",
          "variety": "Popper",
          "color": "Orange/White",
          "weight": 1.5,
        }
      }

      headers = { "CONTENT_TYPE" => "application/json" } 
      patch "/api/v2/users/#{user.id}/lures/#{lure.id}", headers: headers, params: JSON.generate(params)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      updated_lure = Lure.find(lure.id)
      lure_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(lure_data).to be_a(Hash)
      expect(lure_data).to have_key(:data)
      expect(lure_data[:data]).to be_a(Hash)
      expect(lure_data[:data]).to have_key(:id)
      expect(lure_data[:data][:id]).to eq(updated_lure.id.to_s)
      expect(lure_data[:data]).to have_key(:type)
      expect(lure_data[:data][:type]).to eq("lure")
      expect(lure_data[:data]).to have_key(:attributes)
      expect(lure_data[:data][:attributes]).to be_a(Hash)
      expect(lure_data[:data][:attributes]).to have_key(:brand)
      expect(lure_data[:data][:attributes][:brand]).to eq(updated_lure.brand)
      expect(lure_data[:data][:attributes]).to have_key(:variety)
      expect(lure_data[:data][:attributes][:variety]).to eq(updated_lure.variety)
      expect(lure_data[:data][:attributes]).to have_key(:color)
      expect(lure_data[:data][:attributes][:color]).to eq(updated_lure.color)
      expect(lure_data[:data][:attributes]).to have_key(:weight)
      expect(lure_data[:data][:attributes][:weight]).to eq(updated_lure.weight)
    end

    it "cannot update a lure w/ invalid params" do 
      user = create(:user)
      lure = user.lures.create(brand: "Rapala", variety: "Popper", color: "Orange/White", weight: 1.5)

      params = {
        "lure": {
          "brand": "",
          "variety": "Popper",
          "color": "Blue/White",
          "weight": 1.5,
        }
      }

      headers = { "CONTENT_TYPE" => "application/json" } 
      patch "/api/v2/users/#{user.id}/lures/#{lure.id}", headers: headers, params: JSON.generate(params)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:error)
      expect(error_data[:error]).to eq("Validation failed: Brand can't be blank")
    end

    it "cannot update a lure w/ invalid lure_id" do 
      user = create(:user)
      lure = user.lures.create(brand: "Rapala", variety: "Popper", color: "Orange/White", weight: 1.5)

      params = {
        "lure": {
          "brand": "Rapala",
          "variety": "Popper",
          "color": "Orange/White",
          "weight": 1.5,
        }
      }

      headers = { "CONTENT_TYPE" => "application/json" } 
      patch "/api/v2/users/#{user.id}/lures/999", headers: headers, params: JSON.generate(params)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:error)
      expect(error_data[:error]).to eq("No Lure with that ID could be found")
    end
  end
end