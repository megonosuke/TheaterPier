class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @status   = User.select("is_delete").find_by(id: params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "会員情報を更新しました。"
    else
      flash.now[:danger] = "エラーが発生しました"
      @status   = User.select("is_delete").find_by(id: params[:id])
      render 'show'
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :email, :is_delete)
  end
end
