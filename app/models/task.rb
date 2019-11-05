class Task < ApplicationRecord
  belongs_to :user
  has_many :labels, dependent: :destroy
  has_many :label_labelings, through: :labels, source: :labling
  validates :name , presence:true, length: { maximum:100 }
  validates :detail , presence:true, length: { maximum:300 }
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
