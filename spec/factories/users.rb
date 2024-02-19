FactoryBot.define do
  factory :user do
    f_name { Faker::Name.first_name }
    l_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    
  end
end
