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
  end

  def edit
  end

  def index
  end

  private

    def group_params
      params.require(:group).permit(:name)
    end
end
