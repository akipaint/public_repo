class HomeController < ApplicationController
  def index
  end

  def feed

    if !user_signed_in? # ユーザーがログインしていない場合の処理
      @recommended_posts = RecommendationService.recommend_posts_for_guest_user
    else
      @recommended_posts = RecommendationService.recommend_posts_for_user(current_user)
    end
  end


  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @image_posts = @tag.image_posts
    @music_posts = @tag.music_posts
  end
end
