require 'rails_helper'

RSpec.describe "CurrentUsers", type: :request do
  describe "GET /index" do
    let(:user_params) do
      {
        user: {
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }
    end

    it "returns http success" do
      # Simulate user registration
      post user_registration_path, params: user_params
      expect(response).to have_http_status(:ok)

      # Simulate user login to obtain JWT token
      post user_session_path, params: { user: { email: user_params[:user][:email], password: user_params[:user][:password] } }
      token = response.headers['Authorization'].split(' ').last

      # Make a request to the protected route with the token
      get current_user_path, headers: { 'Authorization': "Bearer #{token}" }
      expect(response).to have_http_status(:success)
    end
  end
end

