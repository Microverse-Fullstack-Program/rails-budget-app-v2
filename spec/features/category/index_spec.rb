# Test the category index page
# /spec/integrations/category/index_spec.rb
# -----------------------------------------------------------
require 'rails_helper'

RSpec.describe 'Category index page', type: :feature do
  before(:each) do
    user = User.new(name: 'User-1', email: 'local@host', password: 'password', password_confirmation: 'password')
    user.save
    sign_in user

    @category = Category.new(name: 'Test category', icon: 'test-icon.png', author: user)
    @category.save
    visit categories_path
  end

  it 'displays the category index page' do
    expect(page).to have_content('CARTEGORIES')
    expect(page).to have_content('Logout')
  end

  it 'displays a list of categories' do
    expect(page).to have_content('Test category')
    expect(page).to have_content('Total: 0.0$')
  end

  it 'displays a link to create a new category' do
    expect(page).to have_link('Add Category', href: new_category_path)
  end
end
