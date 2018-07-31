class GroupsController < ApplicationController
  after_action :verify_authorized

  def new
    @group = Group.new
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    authorize @group

    if @group.save
      flash[:success] = "New group was created"
      redirect_to @group
    else
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:id])
    authorize @group
    @books = @group.books
  end

  def edit
    @group = Group.find(params[:id])
    authorize @group
  end

  def  update
    @group = Group.find(params[:id])
    authorize @group

    if @group.update(group_params)
      redirect_to group_path(@group)
      flash[:notice] = "Group successfully edited"
    else
      render "edit"
    end
  end

  def index
    @groups = Group.all
    authorize @groups
  end

  def destroy
    @group = Group.find(params[:id])
    authorize @group

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
