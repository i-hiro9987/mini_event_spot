class Participation < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :comment, length: { maximum: 30 }
  validates :user_id, uniqueness: { scope: :event_id, message: "は既に参加しています" }
end
