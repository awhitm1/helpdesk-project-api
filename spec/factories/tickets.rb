FactoryBot.define do
  factory :ticket do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    user_id { create(:user).id }
    category_id { Category.create(name: Faker::Lorem.word).id }
    location_id { Location.create(name: Faker::Lorem.word).id }
    group_id { Group.create(name: Faker::Lorem.word).id }
    status_id { Status.create(name: Faker::Lorem.word).id }
    is_open { true }
    assigned_tech_id { create(:user).id }
  end
end
