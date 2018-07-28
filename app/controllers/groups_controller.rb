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
    @group = Group.find(params[:id])
  end

  def  update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      redirect_to group_path(@group)
      flash[:notice] = "Group successfully edited"
    else
      render "edit"
    end
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
