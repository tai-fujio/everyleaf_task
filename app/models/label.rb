class Label < ApplicationRecord
  belongs_to :labeling
  belongs_to :task
end
