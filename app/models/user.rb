class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :participated_events, through: :participations, source: :event

  def self.find_or_create_from_auth(auth)
    find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.name = auth["info"]["name"] || auth["info"]["nickname"]
      user.email = auth["info"]["email"]
      user.image_url = auth["info"]["image"]
    end
  end
end
