class User::LikesController < ApplicationController
  before_action :authenticate_user! # ログインしているユーザーのみがいいねできるようにする

  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(user: current_user, post: @post)
  
    if @like.save
      # 作成成功時の処理
      puts "いいねが作成されました。"
      redirect_to @post, notice: '投稿にいいねしました。'
    else
      # 作成失敗時の処理
      puts "いいねの作成に失敗しました。"
      redirect_to @post, alert: 'いいねに失敗しました。'
    end
  end


  def destroy
    @post = Post.find(params[:post_id])
    @like = Like.find_by(user: current_user, post: @post)

    if @like
      @like.destroy
      redirect_to @post, notice: 'いいねを取り消しました。'
    else
      redirect_to @post, alert: 'いいねの取り消しに失敗しました。'
    end
  end
  
  def index
  end


end
