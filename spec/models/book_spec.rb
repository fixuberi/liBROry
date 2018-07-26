require 'rails_helper'

RSpec.describe Book do
  let(:author) { Author.create(name: 'Goodman') }
  let(:group)  { Group.create(name: 'culture') }

  before do
    @book = Book.new(title:'very awesome title',
                     authors: [author],
                     groups: [group])
  end


  subject { @book }

  it { should respond_to :title }
  it { should respond_to :authors }
  it { should respond_to :groups }
  it { should respond_to :cover }

  describe "with blank title" do
    before { @book.title = '' }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @book.title = 'x'*26 }
  end

  describe "without any author" do
    before { @book.authors = [] }
    it { should_not be_valid }
  end

  describe "without any group" do
    before { @book.groups = [] }
    it { should_not be_valid }
  end

end