class Labeling < ApplicationRecord
  belongs_to :task
  has_many :labels, dependent: :destroy
  has_many :label_tasks, through: :labels, source: :task
end
