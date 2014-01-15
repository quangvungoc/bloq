FactoryGirl.define do
  factory :user do
    name     "Quang"
    email    "qq@bloq.com"
    email_confirmation  "qq@bloq.com"
    password "password"
    password_confirmation "password"
  end

  factory :entry do
    title "Entry title"
    body "Entry content"
    user
  end
end
