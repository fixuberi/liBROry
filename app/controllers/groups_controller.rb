class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "New group was created"
      redirect_to @group
    else
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:id])
    @books = @group.books
  end

  def edit
  end

  def index
    @groups = Group.all
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      flash[:success] = "Group deleted"
      redirect_to root_path
    end
  end

  private

    def group_params
      params.require(:group).permit(:name)
    end
end
