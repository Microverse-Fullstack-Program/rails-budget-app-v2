# Test Entities controller
# /spec/requests/entities_controller_spec.rb

require 'rails_helper'

RSpec.describe 'Entities', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    user = User.new(name: 'User-1', email: 'local@host', password: 'password', password_confirmation: 'password')
    user.save
    category = Category.new(name: 'Category-1x', icon: 'fa fa-bolt', author: user)
    category.save
    entity = Entity.new(name: 'Entity-1x', amount: 2345, author: user, category:)
    entity.save
    sign_in user
  end

  describe 'GET categories/:category_id/entities' do
    before do
      get category_entities_path(Category.first)
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'displays the index template' do
      expect(response).to render_template(:index)
    end

    it 'includes entity name and amount in the response body' do
      expect(response.body).to include('Entity-1')
      expect(response.body).to include('2345')
    end

    it 'inludes New Transaction button' do
      expect(response.body).to include('New Transaction')
    end

    it 'should have a link to add new transaction' do
      expect(response.body).to include(new_category_entity_path(Category.first))
    end
  end

  describe 'GET categories/:category_id/entities/new' do
    before do
      get new_category_entity_path(Category.first)
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'displays the new template' do
      expect(response).to render_template(:new)
    end

    it 'inludes placeholder text in the response body' do
      expect(response.body).to include('Name')
      expect(response.body).to include('Price')
    end

    it 'includes New Transaction in the response body' do
      expect(response.body).to include('New Transaction')
    end

    it 'includes Save button' do
      expect(response.body).to include('Save')
    end

    it 'should have a link to categories create' do
      expect(response.body).to include(category_entities_path(Category.first))
    end
  end

  describe 'Post categories/:category_id/entities' do
    before do
      post category_entities_path(Category.first), params: { entity: { name: 'Entity-2', amount: 651 } }
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:redirect)
    end

    it 'should create a new entity' do
      expect(Entity.count).to eq(2)
    end

    it 'should redirect to category entities' do
      expect(response).to redirect_to(category_entities_path(Category.first))
    end

    it 'should display index template' do
      follow_redirect!
      expect(response).to render_template(:index)
    end

    it 'should display entity name and amount in the response body' do
      follow_redirect!
      expect(response.body).to include('Entity-2')
      expect(response.body).to include('651')
    end
  end
end
