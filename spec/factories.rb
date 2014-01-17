FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :book do
    sequence(:title)  { |n| "Title #{n}" }
    sequence(:author) { |n| "Author #{n}" }
  end
end