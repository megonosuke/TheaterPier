class User::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :destroy]
  before_action :authenticate_user!, only: [:like, :unlike]



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
    if params[:keyword]
      @posts = Post.search_by_keyword(params[:keyword])
    elsif params[:tag]
      @posts = Post.search_by_tag(params[:tag])
    else
      @posts = Post.all
    end
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

  def like
    @post = Post.find(params[:id])
    @post.likes.create(user: current_user)
    redirect_to post_path(@post), notice: '投稿にいいねしました。'
  end

  def unlike
    @post = Post.find(params[:id])
    like = @post.likes.find_by(user: current_user)
    like.destroy if like
    redirect_to post_path(@post), notice: 'いいねを取り消しました。'
  end
  
  def toggle_published
    @post = Post.find(params[:id])
    @post.toggle!(:is_published)
    redirect_to post_path(@post), notice: '公開状態を切り替えました。'
  end





  private

  def post_params
    params.require(:post).permit(:title, :content, :tag_names)
  end
  
  

  def is_matching_login_user
    @post = Post.find(params[:id])
    @user = @post.user
    unless @user.id == current_user.id
      redirect_to posts_path
    end
  end
  
  def set_post
    @post = Post.find(params[:id])
  end

end
