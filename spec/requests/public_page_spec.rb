require 'rails_helper'

RSpec.describe "Home" do
  subject { page }
  
  before { visit root_path }

  let(:user) { FactoryGirl.create(:user) }

  describe "for non-signed-in users" do
    it { should have_link("Sign up", href: new_user_registration_path) }
    it { should have_link("Login", href: new_user_session_path) }
  end

  describe "for signed-in users" do
    before { valid_signin user }

    it { should have_link"Edit profile", href:edit_user_registration_path }
    it { should have_link"Logout", href: destroy_user_session_path }
  end
end