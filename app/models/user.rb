class User < ApplicationRecord
  has_secure_password
  before_validation { email.downcase! }
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { maximum:30 }
  validates :password, length: { minimum:6 }
  validates :email, presence: true, uniqueness: true, length: { maximum:150 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
