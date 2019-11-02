class Task < ApplicationRecord
  validates :name , presence:true
  validates :detail , presence:true
  validates :status , presence:true
  validates :priority , presence:true
  validates :deadline , presence:true
  validate :date_check

  default_scope -> { order(created_at: :desc) }
  scope :search_by_name, -> (word){where("name like ?","%#{word}%") if word.present?}

  def date_check
    if deadline
      if deadline < Time.strptime(Time.now.strftime("%Y-%m-%d"),'%Y-%m-%d')
      errors.add(:deadline, "は本日以降の日付を選択してください")
      end
    end  
  end  
end
