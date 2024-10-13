class MatchPostsController < ApplicationController
  before_action :set_match_post, only: [:show, :edit, :update, :destroy]

  # GET /match_posts
  def index
    @match_posts = MatchPost.all
  end

  def show
    @match_post = MatchPost.find(params[:id])
  end

  def new
    unless current_user
      redirect_to match_posts_path, alert: "ログインが必要です。"
      return
    end

    @match_post = MatchPost.new


    if params[:image_post_id].present?
      @image_post = ImagePost.find(params[:image_post_id])
      @source_post = @image_post
    elsif params[:music_post_id].present?
      @music_post = MusicPost.find(params[:music_post_id])
      @source_post = @music_post
    else
      # どちらのIDも存在しない場合の処理
      redirect_to match_posts_path, alert: "画像または音楽の投稿が見つかりませんでした。"
    end

    @selected_matches = new_candidates(@source_post)

  end

  def edit
    @image_posts = ImagePost.all
    @music_posts = MusicPost.all
  end

  def create
    @match_post = MatchPost.new(match_post_params)

    if @match_post.save
      redirect_to @match_post, notice: 'Match post was successfully created.'
    else
      @image_posts = ImagePost.all
      @music_posts = MusicPost.all
      render :new
    end
  end

  # PATCH/PUT /match_posts/1
  def update
    if @match_post.update(match_post_params)
      redirect_to @match_post, notice: 'Match post was successfully updated.'
    else
      @image_posts = ImagePost.all
      @music_posts = MusicPost.all
      render :edit
    end
  end

  # DELETE /match_posts/1
  def destroy
    @match_post.destroy
    redirect_to match_posts_url, notice: 'Match post was successfully destroyed.'
  end


  def new_candidates(source_post)

    @match_candidates = find_match_candidates(source_post)

    selection_process = MatchingService.new(@match_candidates)

    @selected_matches = selection_process.select_matches(3)

    @selected_matches
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match_post
      @match_post = MatchPost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def match_post_params
      params.require(:match_post).permit(:image_post_id, :music_post_id)
    end

    def image_post_params
      params.require(:image_post_id)
    end


    # マッチする候補投稿の配列を取得
    def find_match_candidates(source_post)

      Rails.logger.info "source_post: #{source_post}"


      # マッチする候補投稿をタグを使って絞り込む
      finder = MatchCandidateFinder.new(source_post)
      candidates = finder.find_candidates
      Rails.logger.info "candidates: #{candidates}"

      # マッチ度を候補投稿配列に付加する関数を呼び出す
      matcher = TagMatcher.new
      matched_candidates = matcher.process_candidates(source_post, candidates)

      Rails.logger.info "matched_candidates: #{matched_candidates}"

      matched_candidates
    end

end
