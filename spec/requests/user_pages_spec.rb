require 'rails_helper'

RSpec.describe "User pages:" do
  subject { page }

  let!(:test_user) { FactoryGirl.create(:user) }
  before { valid_signin test_user }
  let!(:user) { FactoryGirl.create(:user) }

  describe "As ADMIN:" do
    before { Permission.create(name:"admin", user: test_user) }

    it { should have_link "Users", href: users_path }

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
      before { visit user_path(user) }
      it "should have user email and edit, delete links" do
        expect(page).to have_content user.email
        expect(page).to have_link "edit", href: edit_user_path(user)
        expect(page).to have_link 'delete', href: user_path(user)
      end

      describe "User permissions editing" do
        before do
          user.permissions.clear
          click_link 'edit'
        end

        it { should have_current_path(edit_user_path(user)) }

        describe "active book_editor permission" do
          before { check_permission_for_editing Book }

          it "should add permission to user" do
            expect{ click_button "Update permissions" }.to change(user.permissions, :count).by(1)
          end
        end

        describe "active group_editor permission" do
          before { check_permission_for_editing Group }

          it "should add permission to user" do
            expect{click_button "Update permissions"}.to change(user.permissions, :count).by(1)
          end
        end

      end

      describe "User destruction" do
        it "click delete link" do
          expect{ click_link 'delete' }.to change(User, :count).by(-1)
        end
      end
    end
  end

  describe "As NON-ADMIN" do
    it { expect(page).not_to have_link "Users", href: users_path }

    describe "when GET to Users list" do
      before { visit users_path }
      describe "should redirect with alert message" do
        it { should have_current_path(root_path) }
        it { should have_error_message "not authorized" }
      end
    end

    describe "when GET to another user page" do
      before { visit users_path(user) }
      describe "should redirect with alert message" do
        it { should have_current_path(root_path) }
        it { should have_error_message "not authorized" }
      end
    end

    describe "when GET to edit current_user permissions" do
      before { visit edit_user_path(user) }
      describe "should redirect with alert message" do
        it { should have_current_path(root_path) }
        it { should have_error_message "not authorized" }
      end
    end
  end
end





