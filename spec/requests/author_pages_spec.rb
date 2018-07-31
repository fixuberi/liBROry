require 'rails_helper'

RSpec.describe "Author pages" do
  subject { page }

  let!(:user) { FactoryGirl.create(:user) }
  before do
    Permission.create(name: "admin", user: user)
    valid_signin user
  end

  describe "Author creation" do
    before { visit new_author_path }

    describe "with invalid information" do
      it "should not create author" do
        expect{ click_button "Create author" }.not_to change(Author, :count)
      end

      describe "error messages" do
        before { click_button "Create author" }
        it { should have_content('error') }
        it { should have_selector('div.alert') }
      end
    end

    describe "with valid information" do
      before { fill_in 'author_name', with: Faker::Name.name }
      it "should create author" do
        expect{ click_button "Create author" }.to change(Author, :count).by(1)
      end
    end
  end

  describe "Author profile" do
    let!(:author) { FactoryGirl.create(:author) }
    let! (:group) { FactoryGirl.create(:group) }
    before do
      FactoryGirl.create(:book, authors: [author], groups: [group])
      visit author_path(author)
    end

    it { should have_content author.name }

    describe "should display the author's books" do
        it "with book's title" do
          author.books.each do |book|
            expect(page).to have_content(book.title)
          end
        end
        it "with book's cover" do
          author.books.each do |book|
            expect(page).to have_css("img[alt='#{book.title}']")
          end
        end
    end
  end

  describe "Authors list page" do
    let!(:author1) { FactoryGirl.create(:author) }
    let!(:author2) { FactoryGirl.create(:author) }
    before { visit authors_path }

    describe "click New author link" do
      before { click_link 'New author' }
      it { should have_current_path(new_author_path) }
    end
    describe "should have existing author names" do
      it { should have_content author1.name }
      it { should have_content author2.name }
    end
  end

  describe "Author destruction" do
    let!(:author) { FactoryGirl.create(:author) }
    before { visit author_path(author) }

    it { should have_link "delete" }
    it "should destroy author" do
        expect {click_link "delete"}.to change(Author, :count).by(-1)
    end
  end

  describe "Author editing" do
    let!(:author) { FactoryGirl.create(:author) }
    before { visit edit_author_path(author) }

    describe "click edit_link" do
      before do
        visit author_path(author)
        click_link 'edit'
      end
      it { should have_current_path(edit_author_path(author)) }
    end

    describe "with valid name" do
      let(:valid_name) { Faker::Book.author }
      before { update_author_with valid_name }

      it "should update author" do
        expect(author.reload.name).to eq valid_name
      end
    end

    describe "with invalid name" do

      describe "empty name" do
        before { update_author_with '' }
        it { should have_error_message "error" }
        it { expect(author.reload.name).not_to be_empty }
      end

      describe "name is too long" do
        let(:long_name) { 'x'*51 }
        before { update_author_with long_name }
        it { should have_error_message "error" }
        it { expect(author.reload.name).not_to eq long_name  }
      end
    end
  end
end
