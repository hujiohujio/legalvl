class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def show
  end
  
  def edit
    redirect_to root_path if current_user != @user
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    if current_user.destroy
      redirect_to root_path
    else
      render :edit
    end
  end


  private
  def user_params
    params.require(:user).permit(:nickname, :profile, :fav_subj, :weak_subj, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
