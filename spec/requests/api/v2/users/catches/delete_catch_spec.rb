require "rails_helper"

RSpec.describe "Catch", type: :request do
  describe "DELETE /api/v2/users/:user_id/catches/:id" do
    it "can delete a catch w/ valid params" do
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

      headers = { "CONTENT_TYPE" => "application/json" }
      delete "/api/v2/users/#{user.id}/catches/#{catch.id}", headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect{ Catch.find(catch.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "cannot delete a catch that does not exist" do 
      user = create(:user)

      headers = { "CONTENT_TYPE" => "application/json" }
      delete "/api/v2/users/#{user.id}/catches/1", headers: headers

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:error)
      expect(error_data[:error]).to eq("No Catch with that ID could be found")
    end
  end
end