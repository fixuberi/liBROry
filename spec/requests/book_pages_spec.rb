require 'rails_helper'

RSpec.describe "Books page:" do
  subject {page}

  let(:user) { FactoryGirl.create(:user) }
  before do
    Permission.create(name: "book_editor", user: user)
    valid_signin user
  end

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

  describe "Books list page" do
    let!(:book1) { FactoryGirl.create(:book, authors: [author], groups: [group]) }
    let!(:book2) { FactoryGirl.create(:book, authors: [author], groups: [group]) }
    before { visit books_path }

    describe "click New book link" do
      before { click_link 'New book' }
      it { should have_current_path(new_book_path) }
    end
    describe "should have existing book names" do
      it { should have_content book1.title }
      it { should have_content book2.title }
    end
  end


  describe "Book destruction" do
    let!(:book) { FactoryGirl.create(:book, authors: [author], groups: [group]) }
    before { visit book_path(book) }

    it { should have_link "delete" }
    it "should destroy book" do
        expect {click_link "delete"}.to change(Book, :count).by(-1)
    end
  end

  describe "Book editing" do
    let!(:book) { FactoryGirl.create(:book, authors: [author], groups: [group]) }
    before { visit edit_book_path(book) }

    describe "click edit_link" do
      before do
        visit book_path(book)
        click_link 'edit'
      end
      it { should have_current_path(edit_book_path(book)) }
    end

    describe "with valid info" do
      let(:valid_title) { Faker::Book.title }
      before { update_book_with valid_title }

      it "should update book" do
        expect(book.reload.title).to eq valid_title
      end
    end

    describe "with invalid info" do

      describe "empty title" do
        before { update_book_with '' }
        it { should have_error_message "error" }
        it { expect(book.reload.title).not_to be_empty }
      end

      describe "title is too long" do
        let(:long_title) { 'x'*51 }
        before { update_book_with long_title }
        it { should have_error_message "error" }
        it { expect(book.reload.title).not_to eq long_title  }
      end

      describe "with invalid attachment" do
        it "should not be updated"
      end

      describe "without any author" do
        before do
          book.authors.each { |author| check_out author }
          click_button 'Update book'
        end
        it { expect(book.reload.authors.count).not_to eq 0 }
      end

      describe "without any group" do
        before do
          book.groups.each { |group| check_out group }
          click_button 'Update book'
        end
        it { expect(book.reload.groups.count).not_to eq 0 }
      end
    end
  end
end