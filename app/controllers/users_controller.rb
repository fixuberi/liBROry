class UsersController < ApplicationController
  after_action :verify_authorized

  def index
    @users = User.all
    redirect_to root_path unless authorize @users
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user

    if @user.destroy
      flash[:notice] = "User deleted"
      redirect_to users_path
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
    @roles = Permission::ROLES
  end

  def update
    @user = User.find(params[:id])
    authorize @user

    if params["book_editor"]
      Permission.create(name:'book_editor', user: @user) unless @user.permit?("book_editor")
    else
      @user.permissions.find_by(name: "book_editor").delete if @user.permit?("book_editor")
    end

    if params["group_editor"]
      Permission.create(name:'group_editor', user: @user) unless @user.permit?("group_editor")
    else
      @user.permissions.find_by(name: "group_editor").delete if @user.permit?("group_editor")
    end
      redirect_to user_path(@user)
      flash[:notice] = "User permissions successfully updated"

  end


  private

    def user_params
      params.require(:user).permit[:id, :book_editor, :group_editor]
    end



end
