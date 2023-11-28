require "rails_helper"

RSpec.describe "Lures", type: :request do
  describe "DELETE /api/v2/users/:user_id/lures/:id" do 
    it "can delete a lure" do 
      user = create(:user)
      lure = user.lures.create(brand: "Rapala", variety: "Popper", color: "Orange/White", weight: 1.5)

      headers = { "CONTENT_TYPE" => "application/json" }
      delete "/api/v2/users/#{user.id}/lures/#{lure.id}", headers: headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect{ Lure.find(lure.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "cannot delete a lure that does not exist" do 
      user = create(:user)

      headers = { "CONTENT_TYPE" => "application/json" }
      delete "/api/v2/users/#{user.id}/lures/1", headers: headers

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:error)
      expect(error_data[:error]).to eq("No Lure with that ID could be found")
    end
  end
end