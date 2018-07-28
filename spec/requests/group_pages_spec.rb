require 'rails_helper'

RSpec.describe "Groups Pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { valid_signin user }

  describe "Group creation" do
    before { visit new_group_path }

    describe "with invalid information" do
      it "should not create group" do
        expect{ click_button "Create group" }.not_to change(Group, :count)
      end

      describe "error messages" do
        before { click_button "Create group" }
        it { should have_content('error') }
        it { should have_selector('div.alert') }
      end
    end

    describe "with valid information" do
      before { fill_in 'group_name', with: Faker::Name.name }
      it "should create group" do
        expect{ click_button "Create group" }.to change(Group, :count).by(1)
      end
    end
  end

  describe "Group page" do
    let!(:author) { FactoryGirl.create(:author) }
    let! (:group) { FactoryGirl.create(:group) }
    before do
      Book.create(title:'a', authors:[author], groups:[group])
          .cover.attach(io: File.open(Rails.root.join 'spec/support/cover.jpg'),
                        filename: 'cover.jpg',
                        content_type: 'image/jpg')
      visit group_path(group)
    end

    it { should have_content group.name }

    describe "should display books in that group" do
      it "with book's title" do
        group.books.each do |book|
          expect(page).to have_content(book.title)
        end
      end
      it "with book's cover" do
        group.books.each do |book|
          expect(page).to have_css("img[alt='#{book.title}']")
        end
      end
    end
  end

  describe "Groups list page" do
    let!(:group1) { FactoryGirl.create(:group) }
    let!(:group2) { FactoryGirl.create(:group) }
    before { visit groups_path }

    describe "click New group link" do
      before { click_link 'New group' }
      it { should have_current_path(new_group_path) }
    end

    describe "should have existing group names" do
      it { should have_content group1.name }
      it { should have_content group2.name }
    end
  end

  describe "Group destruction" do
    let!(:group) { FactoryGirl.create(:group) }
    before { visit group_path(group) }

    it { should have_link "delete" }
    it "should destroy group" do
        expect {click_link "delete"}.to change(Group, :count).by(-1)
    end
  end
end
