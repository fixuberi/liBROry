include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password '123456'
    password_confirmation '123456'
  end

  factory :author do
    name Faker::Book.author
  end

  factory :group do
    name Faker::Book.genre
  end

  factory :book do
    title Faker::Book.title
    cover  { fixture_file_upload(Rails.root.join('spec/support/cover.jpg'), 'image/jpg') }
    association author
  end
end

