class MusicPostsController < ApplicationController
  def new
    unless current_user
      redirect_to music_posts_path, alert: "ログインが必要です。"
      return
    end
    @music_post = MusicPost.new
  end

  def create
    @music_post = current_user.music_posts.build(music_post_params)

    # 受け取った値を,で区切って配列にする
    tag_list = params[:music_post][:name].split(',')

    if @music_post.save
      @music_post.save_tags(tag_list)
      # redirect_to music_post_path(@music_post), notice: "音楽作品を投稿しました"
      redirect_to new_match_post_path(music_post_id: @music_post.id), notice: "音楽作品を投稿しました。マッチングする投稿を選んでください。"
    else
      render :new
    end
  end

  def index
    @music_posts = MusicPost.all.order(id: "DESC")
  end

  def show
    @music_post = MusicPost.find(params[:id])
    @tag_list = @music_post.tags
    @music_post_tags = @music_post.tags
    @image_posts = @music_post.image_posts
  end

  def edit
    @music_post = MusicPost.find(params[:id])

    # 受け取った値を,で区切って配列にする
    @tag_list = @music_post.tags.pluck(:name).join(',')

    if @music_post.user != current_user
      redirect_to music_posts_path, alert: "不正なアクセスです"
    end
  end

  def update
    @music_post = MusicPost.find(params[:id])

    tag_list = params[:music_post][:name].split(',')

    if @music_post.update(music_post_params)
      @music_post.save_tags(tag_list)
      redirect_to music_post_path(@music_post), notice: "音楽投稿を更新しました"
    else
      render :edit
    end
  end


  private
  def music_post_params
    params.require(:music_post).permit(:title, :music)
  end
end
