require 'rails_helper'

RSpec.describe Book do
  let(:author) { Author.create(name: 'Goodman') }
  let(:group)  { Group.create(name: 'culture') }

  before do
    @book = Book.new(title:'very awesome title',
                     authors: [author],
                     groups: [group])
    @book.cover.attach(io: File.open(Rails.root.join 'spec/support/cover.jpg'),
                       filename: 'cover.jpg',
                       content_type: 'image/jpg')
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

  describe "cover attachment" do
    describe "without cover image" do
      before { @book.cover.purge }
      it { should_not be_valid }
    end
    describe "when attachment type is wrong(not JPEG or PNG)" do
      before do
        @book.cover.purge
        @book.cover.attach(io: File.open(Rails.root.join 'spec/rails_helper.rb'),
                       filename: 'rails_helper.rb')
      end
      it { should_not be_valid }
    end
  end


end