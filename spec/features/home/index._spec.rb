# Test Home features with Capybara and RSpec
# /spec/features/home/index_spec.rb

require 'rails_helper'

RSpec.describe 'Home', type: :feature do
  it 'displays the home page' do
    visit root_path

    expect(page).to have_content('Budget Tracker App')
    expect(page).to have_content('Log In')
    expect(page).to have_content('Sign Up')
    expect(page).to have_link('Log In', href: new_user_session_path)
    expect(page).to have_link('Sign Up', href: new_user_registration_path)
  end
end
