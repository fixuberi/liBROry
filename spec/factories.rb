include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "uzver#{n}@gmail.com"}
    password '123456'
    password_confirmation '123456'
  end

  factory :author do
    name Faker::Book.author.gsub(/\W/, '')
  end

  factory :group do
    name Faker::Book.genre.gsub(/\W/, '')
  end

  factory :book do
    title Faker::Book.title.gsub(/\W/, '')
    cover  { fixture_file_upload(Rails.root.join('spec/support/cover.jpg'), 'image/jpg') }
  end

  factory :admin_permission do
    name 'admin'
  end

  factory :book_editor_permission do
    name 'book_editor'
  end

  factory :group_editor_permission do
    name 'group_editor'
  end
end

