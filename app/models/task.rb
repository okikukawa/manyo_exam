class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  enum task_status:{
    未着手:1, 着手中:2, 完了:3
   }
   scope :sort_created_at, -> { order(created_at: "DESC") }
   scope :sort_deadline, -> { order(deadline: "DESC") }
   scope :search_title, -> (title){ where("title LIKE?","%#{title}%") }
   scope :search_status, -> (status){ where(status: status) }
end
