users = []
5.times do |i|
  users << User.create!(
    provider: 'github',
    uid: "test_user_#{i}",
    name: "テストユーザー#{i+1}",
    email: "user#{i+1}@example.com",
    image_url: "https://via.placeholder.com/100"
  )
end

puts "Created #{users.count} users"

events = []
10.times do |i|
  events << Event.create!(
    name: "Rails勉強会 ##{i + 1}",
    description: "Ruby on
Railsについて学ぶ勉強会です。初心者歓迎！\n\n今回のテーマ:
サンプルテーマ#{i + 1}",
    location: "東京都渋谷区#{i + 1}丁目",
    start_at: (i + 1).days.from_now + 10.hours,
    end_at: (i + 1).days.from_now + 12.hours,
    user: users.sample  # ランダムなユーザーを主催者に
  )
end

puts "Created #{events.count} events"
