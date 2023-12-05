require "rails_helper"

RSpec.describe "User API", type: :request do 
  describe "POST /signup" do 
    it "can create a user with valid credentials" do 
      params = {
        "user": {
          "email": "user1@example.com",
          "password": "password123",
          "password_confirmation": "password123"
        }
      }

      headers = { "CONTENT-TYPE" => "application/json" }

      post "/signup", headers: headers, params: JSON.generate(params)

      expect(response).to be_successful
      expect(response).to have_http_status(201)

      new_user = User.last
      user_data = JSON.parse(response.body, symbolize_names: true)

      expect(user_data).to be_a(Hash)
      expect(user_data).to have_key(:data)
      expect(user_data[:data]).to be_a(Hash)
      expect(user_data[:data]).to have_key(:id)
      expect(user_data[:data][:id]).to eq(new_user.id.to_s)
      expect(user_data[:data]).to have_key(:type)
      expect(user_data[:data][:type]).to eq("user")
      expect(user_data[:data]).to have_key(:attributes)
      expect(user_data[:data][:attributes]).to be_a(Hash)
      expect(user_data[:data][:attributes]).to have_key(:email)
      expect(user_data[:data][:attributes][:email]).to eq(new_user.email)
      expect(user_data[:data][:attributes]).to_not have_key(:password)
      expect(user_data[:data][:attributes]).to have_key(:catches)
      expect(user_data[:data][:attributes]).to have_key(:lures)
    end

    it "cannot create a user w/ invalid credentials" do 
      params = {
        "email": "noot@doot.com",
        "password": "password1",
        "password_confirmation": "password3"
      }

      headers = {"CONTENT_TYPE" => "application/json"}  
      post "/signup", headers: headers, params: JSON.generate(user: params) 

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:status)
      expect(error_data[:status][:code]).to eq(422)
      expect(error_data[:status][:message]).to eq("User couldn't be created successfully. Password confirmation doesn't match Password")
    end

    it "cannot create a user w/ an existing email" do 
      existing_user = User.create!(email: "doot@doot.com", password: "password123", password_confirmation: "password123")
      
      params = {
        "email": "doot@doot.com",
        "password": "password123",
        "password_confirmation": "password123"
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/signup", headers: headers, params: JSON.generate(user: params) 

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:status)
      expect(error_data[:status][:code]).to eq(422)
      expect(error_data[:status][:message]).to eq("User couldn't be created successfully. Email has already been taken")
    end

    it "cannot create a user if fields are missing" do 
      params = {
        "email": "",
        "password": "",
        "password_confirmation": ""
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/signup", headers: headers, params: JSON.generate(user: params)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)
      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:status)
      expect(error_data[:status][:code]).to eq(422)
      expect(error_data[:status][:message]).to eq("User couldn't be created successfully. Email can't be blank and Password can't be blank")
    end
  end

  it "can delete a user that is logged in" do 
    user_params = {
      "user": {
        "email": "user2@example.com",
        "password": "password123",
        "password_confirmation": "password123"
      }
    }

    headers = { "CONTENT-TYPE" => "application/json" }

    post "/signup", headers: headers, params: JSON.generate(user_params)
    expect(response).to be_successful
    expect(response).to have_http_status(201)

    post "/login", params: { user: { email: user_params[:user][:email], password: user_params[:user][:password] } }
    expect(response).to be_successful
    token = response.headers['Authorization']

    expect(User.count).to eq(1)
    
    delete user_registration_path, headers: { 'Authorization': token }
    
    expect(response).to be_successful
    expect(response).to have_http_status(200)
    expect(User.count).to eq(0)
  end

  it "cannot delete a user that is not logged in" do 
    user_params = {
      "user": {
        "email": "user2@example.com",
        "password": "password123",
        "password_confirmation": "password123"
      }
    }

    headers = { "CONTENT-TYPE" => "application/json" }

    post "/signup", headers: headers, params: JSON.generate(user_params)

    expect(response).to be_successful

    expect(User.count).to eq(1)

    delete user_registration_path

    expect(response).to_not be_successful
    expect(response).to have_http_status(401)
    expect(response.body).to eq("You need to sign in or sign up before continuing.")
  end

  it "does not allow deletion with invalid token" do
    invalid_token = "invalid_token"
    delete user_registration_path, headers: { 'Authorization': invalid_token }
    expect(response).to have_http_status(401) 
  end

  it "does not delete a non-existent user" do
    delete user_registration_path, headers: { 'Authorization': @token }
    expect(response).to have_http_status(401)
  end
end