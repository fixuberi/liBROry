class BooksController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.authors << Author.find(associated_authors)
    @book.groups << Group.find(associated_groups)

    if @book.save
      flash[:notice] = "New book was created"
      redirect_to @book
    else
      render 'new'
    end
  end

  private

    def book_params
      params.require(:book).permit(:title, :cover)
    end

    def associated_authors
      params.require(:book).permit(:authors)[:authors].to_i
    end

    def associated_groups
      params.require(:book).permit(:groups)[:groups].to_i
    end



end
