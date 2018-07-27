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
  end

  def index
    @author = Author.all
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update

  end

  def destroy

  end

  private

    def author_params
      params.require(:author).permit(:name)
    end
end
