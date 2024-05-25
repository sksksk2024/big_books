module Admin
  class RolesController < ApplicationController
    before_action :set_user, only: [:edit, :update]

    def edit
    end

    def update
      if @user.update(role_params)
        redirect_to admin_role_path(@user), notice: 'Role was successfully updated.'
      else
        render :edit
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def role_params
      params.require(:user).permit(:role)
    end
  end
end

