class Labeling < ApplicationRecord
  has_many :labels, dependent: :destroy
  has_many :label_tasks, through: :labels, source: :task
  validates :name, uniqueness: true, presence: true
end
