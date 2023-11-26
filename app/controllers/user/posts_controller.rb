class User::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:notice] = "投稿が作成されました。"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments  
    @comment = current_user.comments.new  
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post =Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿が更新されました。"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: '投稿が削除されました。'
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def is_matching_login_user
    @post = Post.find(params[:id])
    @user = @post.user
    unless @user.id == current_user.id
      redirect_to posts_path
    end
  end
end
