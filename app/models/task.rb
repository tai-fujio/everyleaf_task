class Task < ApplicationRecord
  validates :name , presence:true
  validates :detail , presence:true 
  default_scope -> { order(created_at: :desc) }
  # scope :sorted, ->  { order(created_at: :desc)}
  validate :date_check

  def date_check
    if deadline
      if deadline < Time.strptime(Time.now.strftime("%Y-%m-%d"),'%Y-%m-%d')
      errors.add(:deadline, "は本日以降の日付を選択してください")
      end
    end  
  end  
  
  end
