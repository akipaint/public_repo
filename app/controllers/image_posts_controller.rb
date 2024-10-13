class ImagePostsController < ApplicationController
  def new
    unless current_user
      redirect_to image_posts_path, alert: "ログインが必要です。"
      return
    end
    @image_post = ImagePost.new
    @tag_list = Tag.all
  end

  def create
    @image_post = current_user.image_posts.build(image_post_params)

    # 受け取った値を,で区切って配列にする
    tag_list = params[:image_post][:name].split(',')

    if @image_post.save
      @image_post.save_tags(tag_list)
      # redirect_to image_post_path(@image_post), notice: "画像作品を投稿しました"
      redirect_to new_match_post_path(image_post_id: @image_post.id), notice: "画像作品を投稿しました。マッチングする投稿を選んでください。"
    else
      render :new
    end
  end

  def index
    @image_posts = ImagePost.all.order(id: "DESC")

  end

  def show
    @image_post = ImagePost.find(params[:id])
    @tag_list = @image_post.tags
    @image_post_tags = @image_post.tags
  end

  def edit
    @image_post = ImagePost.find(params[:id])

    # 受け取った値を,で区切って配列にする
    tag_list = params[:image_post][:name].split(',')

    if @image_post.user != current_user
      redirect_to image_posts_path, alert: "不正なアクセスです"
    end
  end

  def update
    @image_post = ImagePost.find(params[:id])

    tag_list = params[:image_post][:name].split(',')

    if @image_post.update(image_post_params)
      @image_post.save_tags(tag_list)
      redirect_to image_post_path(@image_post), notice: "画像投稿を更新しました"
    else
      render :edit
    end
  end


  private
  def image_post_params
    params.require(:image_post).permit(:title, :image)
  end
end
