class AuthorsController < ApplicationController
  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      flash[:success] = "New author was created"
      redirect_to @author
    else
      render 'new'
    end
  end

  def show
    @author = Author.find(params[:id])
    @books = @author.books
  end

  def index
    @authors = Author.all
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])

    if @author.update(author_params)
      redirect_to author_path(@author)
      flash[:notice] = "Author changed his name and happy now"
    else
      render "edit"
    end
  end

  def destroy
    @author = Author.find(params[:id])
    if @author.destroy
      flash[:success] = "Author deleted"
      redirect_to root_path
    end
  end

  private

    def author_params
      params.require(:author).permit(:name)
    end
end
