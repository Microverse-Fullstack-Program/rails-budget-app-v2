# Test the entity new page
# /spec/features/entity/new_spec.rb
# -----------------------------------------------------------

require 'rails_helper'

RSpec.describe 'Entity new page', type: :feature do
  before(:each) do
    user = User.new(name: 'User-1', email: 'local@host', password: 'password', password_confirmation: 'password')
    user.save
    sign_in user

    category = Category.new(name: 'Category-1x', icon: 'fa fa-bolt', author: user)
    category.save

    visit new_category_entity_path(Category)
  end

  it 'displays the entity new page' do
    expect(page).to have_content('New Transaction')
    expect(page).to have_content('Logout')
  end

  it 'displays the entity form' do
    expect(page).to have_field('entity[name]')
    expect(page).to have_field('entity[amount]')
  end

  it 'creates a new entity' do
    fill_in 'entity[name]', with: 'Test entity'
    fill_in 'entity[amount]', with: '1234'
    click_button 'Save'
    expect(current_path).to eq(category_entities_path(Category))
  end
end
