# Test for User model
# spec/modules/user_spec.rb
#
require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryBot.build(:user) }
  
  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'is not valid with a name longer than 60 characters' do
    user.name = ('a' * 61)
    expect(user).to_not be_valid
  end

  it 'is valid with a name of 60 characters or less' do
    user.name = ('a' * 60)
    expect(user).to be_valid

    user.name = ('a' * 40)
    expect(user).to be_valid
  end

  it 'is not valid with a name of less than characters' do
    user.name = 'a'
    expect(user).to_not be_valid
  end

  it 'is not valid with a password shorter than 6 characters' do
    user.name = 'John Doe'
    user.password = '12345'
    user.password_confirmation = '12345'
    expect(user).to_not be_valid
  end

  it 'is valid with a password of 6 characters or more' do
    user.password = '1234569'
    user.password_confirmation = '1234569'
    expect(user).to be_valid
  end

  it 'is not valid with a password confirmation that does not match' do
    user.password = '1234569'
    user.password_confirmation = '1234567'
    expect(user).to_not be_valid
  end

  it 'is valid with a password confirmation that matches' do
    user.password = '1234569'
    user.password_confirmation = '1234569'
    expect(user).to be_valid
  end

  describe 'Associations' do
    it 'should have many categories and entities' do
      user = User.reflect_on_association(:categories)
      expect(user.macro).to eq(:has_many)
      user = User.reflect_on_association(:entities)
      expect(user.macro).to eq(:has_many)
    end
  end
end
