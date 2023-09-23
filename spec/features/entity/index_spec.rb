# Test the entity index page
# /spec/features/entity/index_spec.rb
# -----------------------------------------------------------

require 'rails_helper'

RSpec.describe 'Entity index page', type: :feature do
  before(:each) do
    user = User.new(name: 'User-1', email: 'local@host', password: 'password', password_confirmation: 'password')
    user.save
    sign_in user

    category = Category.new(name: 'Test category', icon: 'test-icon.png', author: user)
    category.save

    @entity = Entity.new(name: 'Test entity', amount: 653, category:, author: user)
    @entity.save

    visit category_entities_path(category)
  end

  it 'displays the entity index page' do
    expect(page).to have_content('Transactions')
    expect(page).to have_content('Logout')
  end

  it 'displays a list of entities' do
    expect(page).to have_content('Test entity')
    expect(page).to have_content('Price: 653.0$')
  end

  it 'displays a link to create a new entity' do
    expect(page).to have_link('New Transaction', href: new_category_entity_path(@entity.category))
  end
end
