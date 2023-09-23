# Test the category new page
# /spec/integrations/category/new_spec.rb
# -----------------------------------------------------------

require 'rails_helper'

RSpec.describe 'Category new page', type: :feature do
  before(:each) do
    user = User.new(name: 'User-1', email: 'local@host', password: 'password', password_confirmation: 'password')
    user.save
    sign_in user

    visit new_category_path
  end

  it 'displays the category new page' do
    expect(page).to have_content('New Category')
    expect(page).to have_content('Logout')
  end

  it 'displays the category form' do
    expect(page).to have_field('Name')
    expect(page).to have_field('Icon Link')
  end

  it 'creates a new category' do
    fill_in 'Name', with: 'Test category'
    fill_in 'Icon Link', with: 'test-icon.png'
    click_button 'Save'
    expect(current_path).to eq(categories_path)
    expect(page).to have_content('Test category')
  end
end
