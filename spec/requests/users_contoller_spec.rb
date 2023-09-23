# Test users controller
# /spec/requests/users_controller_spec.rb

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'GET /root' do
    before do
      get root_path
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'displays the home index template' do
      expect(response).to render_template(:index)
    end

    it 'includes "Budget Tracker App" in the response body' do
      expect(response.body).to include('Budget Tracker App')
    end

    it 'includes "Sign in" in the response body' do
      expect(response.body).to include('Log In')
    end

    it 'includes "Sign up" in the response body' do
      expect(response.body).to include('Sign Up')
    end

    it 'should have a link to sign up' do
      expect(response.body).to include(new_user_registration_path)
    end

    it 'should have a link to sign in' do
      expect(response.body).to include(new_user_session_path)
    end
  end
end
