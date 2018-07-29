require 'rails_helper'

RSpec.describe "Books page:" do
  subject {page}

  let(:user) { FactoryGirl.create(:user) }
  before { valid_signin user }

  let!(:author) { FactoryGirl.create(:author) }
  let!(:group) { FactoryGirl.create(:group) }


  describe "Book creation" do
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
        check_in author
        check_in group
      end

      it "should create book" do
        expect{ click_button "Create book" }.to change(Book, :count).by(1)
      end
    end
  end

  describe "Book page" do
    let!(:second_author) { FactoryGirl.create(:author) }
    let!(:book) { FactoryGirl.create(:book, authors: [author], groups:[group]) }
    before { visit book_path(book) }

    it { should have_content book.title }
    it { should have_css("img[alt='#{book.title}']") }

    describe "should display the authors of that book" do
      it "with author names and refers" do
        book.authors.each do |author|
          expect(page).to have_content(author.name)
          expect(page).to have_link(author.name, href: author_path(author))
        end
      end
    end

    describe "should display the groups of that book" do
      it "with group names and refers" do
        book.groups.each do |group|
          expect(page).to have_content(group.name)
          expect(page).to have_link(group.name, href: group_path(group))
        end
      end
    end

  end
end