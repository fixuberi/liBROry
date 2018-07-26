require 'rails_helper'

RSpec.describe Group do
  before { @group = Group.new(name:'awesome group') }

  subject { @group }

  it { should respond_to :name }

  describe "when name is blank" do
    before { @group.name = '' }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @group.name = 'x'*26 }
    it { should_not be_valid }
  end
end