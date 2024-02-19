FactoryBot.define do
  factory :ticket do
    cat = Category.create(name: Faker::Lorem.word)
    loc = Location.create(name: Faker::Lorem.word)
    group = Group.create(name: Faker::Lorem.word) 
    status = Status.create(name: Faker::Lorem.word) 
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    user_id { create(:user).id }
    category_id { cat.id }
    location_id { loc.id }
    group_id { group.id }
    status_id { status.id }
    is_open { true }
    assigned_tech_id { create(:user).id }
  end
end
