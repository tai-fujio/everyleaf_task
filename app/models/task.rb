class Task < ApplicationRecord
  validates :name , presence:true
  validates :detail , presence:true
  scope :sorted, ->  { order(created_at: :desc)}
end
