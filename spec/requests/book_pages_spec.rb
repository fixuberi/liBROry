require 'rails_helper'

RSpec.describe "Book page" do
  subject {page}

  let(:user) { FactoryGirl.create(:user) }
  before { valid_signin user }

  describe "Book creation" do
    let!(:author) { FactoryGirl.create(:author) }
    let!(:group) { FactoryGirl.create(:group) }
    before { visit new_book_path }

    describe "with invalid information" do
      it "should not create book" do
        expect{ click_button "Create book" }.not_to change(Book, :count)
      end

      describe "error messages" do
        before { click_button "Create book" }
        it { should have_content('error') }
        it { should have_selector('div.alert') }
      end
    end

    describe "with valid information" do
      before do
        fill_in 'book_title', with: Faker::Book.title
        page.attach_file("Cover", File.join(Rails.root, 'spec', 'support', 'cover.jpg'))
        select author.name, :from => "book_authors"
        select group.name, :from => "book_groups"
      end

      it "should create book" do
        expect{ click_button "Create book" }.to change(Book, :count).by(1)
      end
    end
  end
end