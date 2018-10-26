require "faker"

FactoryBot.define do
  factory :user do
    name "Phuc"
    email {Faker::Internet.email}
    password "123456"
    role "user"
    activated "true"
  end
  
  factory :admin, class: User do
    name "admin"
    email { Faker::Internet.email }
    password "123456"
    role "admin"
    activated "true"
  end
end