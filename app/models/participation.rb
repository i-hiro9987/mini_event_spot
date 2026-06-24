class Participation < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :comment, length: { maximum: 500 }
  validates :user_id, uniqueness: { scope: :event_id, message: "は既にこのイベントに参加しています" }
end
