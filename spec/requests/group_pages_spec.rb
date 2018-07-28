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
end