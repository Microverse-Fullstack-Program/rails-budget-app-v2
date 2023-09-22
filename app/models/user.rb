class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many   :categories, dependent: :destroy
  has_many   :entities,   dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 60 }
end
