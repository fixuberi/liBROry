require 'rails_helper'

RSpec.describe Author  do
  before { @author = Author.new(name: 'author') }

  subject { @author }

  it { should respond_to :name }

  describe "with blank name" do
    before { @author.name = '' }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @author.name = 'x'*51 }
    it { should_not be_valid }
  end

end