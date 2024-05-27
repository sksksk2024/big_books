class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      MyBackgroundJob.perform_later(@user.id)
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
