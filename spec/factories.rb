# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Paul Campbell"
  user.email                 "paulcampbell@example.com"
  user.password              "someword"
  user.password_confirmation "someword"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :post do |post|
  post.title "The Post Title"
  post.content "My post content"
  post.association :user
end