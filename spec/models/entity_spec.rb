# Tests for the Entity model
# /spec/models/entity_spec.rb
#
require 'rails_helper'

RSpec.describe Entity, type: :model do
  let(:user) { FactoryBot.build(:user) }
  let(:category) { Category.new(name: 'Test Category', icon: 'fa fa-bolt', author: user) }
  let(:entity) { Entity.new(name: 'Test Entity', amount: 453, category:, author: user) }

  it 'is valid with valid attributes' do
    expect(entity).to be_valid
  end

  it 'is not valid without a name' do
    entity.name = nil
    expect(entity).to_not be_valid
  end

  it 'is not valid with a name longer than 60 characters' do
    entity.name = ('a' * 61)
    expect(entity).to_not be_valid
  end

  it 'is not valid with a name of less than 3 characters' do
    entity.name = 'a'
    expect(entity).to_not be_valid
  end

  it 'is valid with name of length between 3 and 60 characters' do
    entity.name = 'aaa'
    expect(entity).to be_valid

    entity.name = 'a' * 59
    expect(entity).to be_valid
  end

  it 'is not valid without an amount' do
    entity.amount = nil
    expect(entity).to_not be_valid
  end

  it 'is not valid with an amount less than 0' do
    entity.amount = -1
    expect(entity).to_not be_valid
  end

  it 'is not valid with an amount of 0' do
    entity.amount = 0
    expect(entity).to_not be_valid
  end

  it 'is not valid with an amount greater than 10**5' do
    entity.amount = (10**5) + 1
    expect(entity).to_not be_valid
  end

  it 'is valid with an amount between 1 and 10**5 or less' do
    entity.amount = 10**5
    expect(entity).to be_valid

    entity.amount = 10**4
    expect(entity).to be_valid
  end

  it 'is not valid without a category' do
    entity.category = nil
    expect(entity).to_not be_valid
  end

  it 'is valid with a category' do
    entity.category = category
    expect(entity).to be_valid
  end

  it 'is not valid without an author' do
    entity.author = nil
    expect(entity).to_not be_valid
  end

  it 'is valid with an author' do
    entity.author = user
    expect(entity).to be_valid
  end

  describe 'Associations' do
    it 'should belong to a category and an author' do
      entity = Entity.reflect_on_association(:category)
      expect(entity.macro).to eq(:belongs_to)
      entity = Entity.reflect_on_association(:author)
      expect(entity.macro).to eq(:belongs_to)
    end
  end
end
