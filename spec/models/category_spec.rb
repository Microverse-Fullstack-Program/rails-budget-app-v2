# Tests for Category model
# /spec/models/category_spec.rb
#
require 'rails_helper'

RSpec.describe Category, type: :model do
  let (:user) { FactoryBot.build(:user) }
  let (:category) { Category.new(name: 'Test Category', icon: 'fa fa-bolt', author: user) }


  it 'is valid with valid attributes' do
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    category.name = nil
    expect(category).to_not be_valid
  end

  it 'is not valid with a name longer than 60 characters' do
    category.name = ('a' * 61)
    expect(category).to_not be_valid
  end

  it 'is valid with a name of 60 characters or less' do
    category.name = ('a' * 60)
    expect(category).to be_valid

    category.name = ('a' * 40)
    expect(category).to be_valid
  end

  it 'is not valid with a name of less than 3 characters' do
    category.name = 'a'
    expect(category).to_not be_valid
  end

  it 'is valid with name of length between 3 and 60 characters' do
    category.name = 'aaa'
    expect(category).to be_valid

    category.name = 'a' * 59
    expect(category).to be_valid
  end

  it 'is not valid without an icon' do
    category.icon = nil
    expect(category).to_not be_valid
  end

  it 'is valid with a default icon' do
    category.icon = Category.default_icon
    expect(category).to be_valid
  end

  it 'is valid with a custom icon' do
    category.icon = 'fa fa-bolt'
    expect(category).to be_valid
  end

  it 'is not valid without an author' do
    category.author = nil
    expect(category).to_not be_valid
  end

  it 'is valid with an author' do
    category.author = user
    expect(category).to be_valid
  end

  
  describe 'Associations' do
    it 'should belong to author' do
      category = Category.reflect_on_association(:author)
      expect(category.macro).to eq(:belongs_to)
    end

    it 'should have many entities' do
      category = Category.reflect_on_association(:entities)
      expect(category.macro).to eq(:has_many)
    end
  end
end
