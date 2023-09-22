class Entity < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :category, class_name: 'Category', foreign_key: 'category_id'

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 60 }
  validates :amount, presence: true, numericality: { greater_than: 0 }, length: { minimum: 1, maximum: 100 }
end
