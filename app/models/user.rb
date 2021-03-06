class User < ApplicationRecord
  has_secure_password
  before_validation { email.downcase! }
  before_destroy :must_at_least_one_admin
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { maximum:30 }
  validates :password, length: { minimum:6 }
  validates :email, presence: true, uniqueness: true, length: { maximum:150 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  
  private
  def must_at_least_one_admin
    throw(:abort) if User.where(admin_or_not: true).count < 2 && self.admin_or_not == true
  end
end
