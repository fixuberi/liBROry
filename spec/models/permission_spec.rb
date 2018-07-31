require 'rails_helper'

RSpec.describe Permission, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  before { @permission = Permission.new(name:'admin', user: user) }

  subject { @permission}

  it { should respond_to :name }
  it { should respond_to :user }


  describe "when name is blank" do
    before { @permission.name = '' }
    it { should_not be_valid }
  end

end
