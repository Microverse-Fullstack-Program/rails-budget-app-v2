# Test Categories controller
# /spec/requests/categories_controller_spec.rb

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    user = User.new(name: 'User-1', email: 'local@host', password: 'password', password_confirmation: 'password')
    user.save 
    category = Category.new(name: 'Category-1x', icon: 'fa fa-bolt', author: user)
    category.save
    sign_in user
  end

  describe 'GET /categories' do
    before do
      get categories_path
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'displays the index template' do
      expect(response).to render_template(:index)
    end

    it 'includes category name in the response body' do
      expect(response.body).to include('Category-1')
    end

    it 'inludes Add Category button' do
      expect(response.body).to include('Add Category')
    end

    it 'should have a link to add new category' do
      expect(response.body).to include(new_category_path)
    end
  end

  describe 'GET /categories/new' do
    before do
      get new_category_path
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'displays the new template' do
      expect(response).to render_template(:new)
    end

    it 'inludes placeholder text in the response body' do
      expect(response.body).to include('Name')
      expect(response.body).to include('Icon Link')
    end

    it 'includes New Category in the response body' do
      expect(response.body).to include('New Category')
    end

    it 'includes Save button' do
      expect(response.body).to include('Save')
    end

    it 'should have a link to categories create' do
      expect(response.body).to include(categories_path)
    end
  end

  describe 'Post /categories' do
    before do
      post categories_path, params: { category: { name: 'Category-1', icon: 'fa fa-bolt' } }
    end

    it 'returns a success response' do
      expect(response).to have_http_status(302)
    end

    it 'should create a new category' do
      expect(Category.count).to eq(2)
    end

    it 'redirects to categories index' do
      expect(response).to redirect_to(categories_path)
    end

    it 'displays the index template' do
      follow_redirect!
      expect(response).to render_template(:index)
    end

    it 'includes category name in the response body' do
      follow_redirect!
      expect(response.body).to include('Category-1')
    end
  end
end
