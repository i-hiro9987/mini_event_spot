class Event < ApplicationRecord
  belongs_to :user
  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, source: :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 2000 }
  validates :location, length: { maximum: 100 }
  validates :start_at, presence: true
  validates :end_at, presence: true

  validate :end_at_must_be_after_start_at

  scope :upcoming, -> { where("start_at > ?", Time.current).order(:start_at) }

  def created_by?(user)
    return false unless user
    self.user_id == user.id
  end

  private

  def end_at_must_be_after_start_at
    return if start_at.blank? || end_at.blank?

    if end_at <= start_at
      errors.add(:end_at, "は開始時刻よりも後に設定してください")
    end
  end
end
