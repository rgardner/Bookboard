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

  factory :booklist do
    sequence(:title) { |n| "Booklist #{n}" }
    user
  end

  factory :book do
    sequence(:title) { |n| "Title #{n}" }
    booklist
  end
end