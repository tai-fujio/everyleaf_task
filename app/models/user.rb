class User < ApplicationRecord
  has_many :tasks
  before_validation { email.downcase! }
  has_secure_password
  validates :name, presence: true, length: { maximum:30 }
  validates :email, presence: true, uniqueness: true, length: { maximum:150 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence:true, length: { minimum:6 }

end
