class Category < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :entities, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 60 }
  validates :icon, presence: true

  def self.default_icon
    'fas fa-question-circle'
  end

  def total_transactions
    entities.where(category_id: id).sum(:amount).to_f
  end
end
