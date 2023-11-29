require "rails_helper"

RSpec.describe "Sessions", type: :request do 
  describe "POST /api/v2/sessions" do 
    xit "authenticates the user w/ valid credentials" do 
      user = create(:user)

      user_params = {
        "email": user.email,
        "password": user.password 
      }

      headers = {"CONTENT_TYPE" => "application/json"} 

      post "/api/v2/sessions", params: JSON.generate(user_params), headers: headers

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      session_data = JSON.parse(response.body, symbolize_names: true)[:data]
      
      expect(session_data).to have_key(:id)
      expect(session_data[:id]).to eq(user.id.to_s)
      expect(session_data).to have_key(:type)
      expect(session_data[:type]).to eq("user")
      expect(session_data).to have_key(:attributes)
      expect(session_data[:attributes]).to have_key(:email)
      expect(session_data[:attributes][:email]).to eq(user.email)
    end

    xit "does not authenticate the user w/ invalid credentials" do 
      user = create(:user)

      user_params = {
        "email": user.email,
        "password": "IncorrectPassword"
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v2/sessions", params: JSON.generate(user_params), headers: headers

      expect(response).to_not be_successful
      expect(response).to have_http_status(:unauthorized)

      session_data = JSON.parse(response.body, symbolize_names: true)

      expect(session_data).to have_key(:error)
      expect(session_data[:error]).to eq("Invalid credentials")
    end
  end
end