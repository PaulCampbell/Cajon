# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Paul Campbell"
  user.email                 "paulcampbell@example.com"
  user.password              "someword"
  user.password_confirmation "someword"
end