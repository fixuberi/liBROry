require 'rails_helper'

RSpec.describe "Author pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { valid_signin user }

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
      before { fill_in 'author_name', with: 'Adolph' }
      it "should create author" do
        expect{ click_button "Create author" }.to change(Author, :count).by(1)
      end
    end
  end


end