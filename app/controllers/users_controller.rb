class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "User deleted"
      redirect_to users_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find[params[:id]]
    if @user.update(user_params)
      redirect_to user_path(admin)
      flash[:notice] = "User permissions successfully updated"
    else
      render "edit"
    end
  end


  private

    def user_params
      params.require(:user).permit[permission_ids:[]]
    end



end
