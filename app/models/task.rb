class Task < ApplicationRecord
  validates :task_name , presence:true
  validates :task_details , presence:true
end
