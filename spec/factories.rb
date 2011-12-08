Factory.define :user do |user|
  user.sequence(:username) {|n| "username#{n}"}
  user.personality {Factory.build(:user_personality)}
end

Factory.define :user_personality do |personality|
  personality.likes []
end

Factory.define :like do |like|
  like.sequence(:name) {|n| "Test Like #{n}"}
  like.following {Factory.build(:like_following)}
end

Factory.define :like_following do |like_following|
  like_following.users []
end

puts "FACTORIES ARE READ"