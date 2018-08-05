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
  end

  def update
    @user = User.find(params[:id])
    authorize @user

    @user.permission.update(book_editor: params['book_editor'].present?, group_editor: params['group_editor'].present?)

    redirect_to user_path(@user)
    flash[:notice] = "User permissions successfully updated"

  end

  private

  def user_params
    params.require(:user).permit[:id, :book_editor, :group_editor]
  end

end
