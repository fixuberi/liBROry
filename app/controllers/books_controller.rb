class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to book_path(@book)
      flash[:notice] = "Book successfully updated"
    else
      render "edit"
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:notice] = "New book was created"
      redirect_to @book
    else
      render 'new'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice] = "Book deleted"
      redirect_to root_path
    end
  end

  private

    def book_params
      params.require(:book).permit(:title, :cover, author_ids: [], group_ids:[])
    end

end
