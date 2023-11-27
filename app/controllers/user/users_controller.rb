class User::UsersController < ApplicationController
  def show
    @user = current_user
    @posts = @user.posts
  end

  def check
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_delete: true)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end
  
  # def liked_posts
  #   @user = current_user
  #   @liked_posts = @user.liked_posts
  # end

end
