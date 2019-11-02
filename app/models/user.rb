class User < ApplicationRecord
  before_validation { email.downcase! }
  has_many :tasks, dependent: :destroy
  has_secure_password
  validates :name, presence: true, length: { maximum:30 }
  validates :password, presence: true, length: { maximum:30 ,minimum:6 }
  validates :email, presence: true, uniqueness: true, length: { maximum:150 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
