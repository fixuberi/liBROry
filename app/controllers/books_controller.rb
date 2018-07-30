class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.authors << Author.find(associated_author_ids)
    @book.groups << Group.find(associated_group_ids)

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
      params.require(:book).permit(:title, :cover)
    end

    def associated_author_ids
      params.require(:book).permit(authors: [])[:authors].reject(&:empty?)
    end

    def associated_group_ids
      params.require(:book).permit(groups: [])[:groups].reject(&:empty?)
    end



end
