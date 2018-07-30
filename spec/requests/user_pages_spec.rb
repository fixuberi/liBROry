require 'rails_helper'

RSpec.describe "User pages:" do
  subject { page }

  let!(:root_admin) { FactoryGirl.create(:user) }
  before { valid_signin root_admin }

  let!(:admin) { FactoryGirl.create(:user) }

  describe "Users list" do
    before { visit users_path }

    describe "should display existing users" do
      it "with emails and show links" do
        User.all.each do |user|
          expect(page).to have_link user.email, href: user_path(user)
        end
      end
    end
  end

  describe "User page" do
    before { visit user_path(admin) }

    it { expect(page).to have_content admin.email }
    it { expect(page).to have_link "edit", href: edit_user_path(admin) }
    it { expect(page).to have_link 'delete', href: user_path(admin) }



  describe "User editing" do
    before do
     # admin.permissions.clear
      click_link 'edit'
    end

    it { should have_current_path(edit_user_path(admin)) }

    describe "active book_editor permission" do
      #check book_editor_box
      #expect(click_button "Update user").to change(admin.permissions.count).by(1)
    end

    describe "active group_editor permission" do
     # check group_editor_box
     # expect(click_button "Update user").to change(admin.permissions.count).by(1)
    end

  end

  describe "User destruction" do
    it "click delete link" do
      expect{ click_link 'delete' }.to change(User, :count).by(-1)
    end
    end
  end
end
