require 'rails_helper'

RSpec.describe 'Users::SessionsController', type: :request do
  let(:user) { create(:user) }

  describe 'POST /login' do
    context 'with valid credentials' do
      before do
        post "/login", params: { 
          user: { 
            email: user.email, 
            password: user.password 
          } 
        }
      end

      it 'logs in the user' do
        expect(response).to have_http_status(:ok)
        expect(json_response[:status][:message]).to eq('Logged in sucessfully.')
        expect(json_response[:data]).to include(email: user.email)
      end
    end

    context 'with invalid credentials' do 
      before do 
        post "/login", params: { 
          user: { 
            email: user.email, 
            password: 'invalid_password' 
          } 
        }
      end

      it 'does not log in the user' do 
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq("Invalid Email or password.")
      end
    end

    describe 'DELETE /logout' do
      context 'when user is logged in' do
        before do
          post "/login", params: { user: {email: user.email, password: user.password} }
          token = response.headers['Authorization']

          delete "/logout", headers: { 'Authorization': token }
        end
  
        it 'logs out the user' do
          expect(response).to have_http_status(:ok)
          expect(json_response[:status]).to eq(200)
          expect(json_response[:message]).to eq('logged out successfully')
        end
      end
  
      context 'when user is not logged in' do
        before do
          delete "/logout"
        end
  
        it 'responds with unauthorized' do
          expect(response).to have_http_status(:unauthorized)
          expect(json_response[:status]).to eq(401)
          expect(json_response[:message]).to eq("Couldn't find an active session.")
        end
      end
    end
  end

  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end
end
