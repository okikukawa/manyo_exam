class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  enum task_status:{
    未着手:1, 着手中:2, 完了:3
   }
end
