class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        @likeable = find_likeable
        @like = @likeable.likes.build(user: current_user)

        if @like.save
        redirect_to @likeable, notice: 'You liked this post.'
        else
        redirect_to @likeable, alert: 'Unable to like this post.'
        end
    end

    def destroy
        @like = Like.find(params[:id])
        @likeable = @like.likeable

        if @like.destroy
        redirect_to @likeable, notice: 'You unliked this post.'
        else
        redirect_to @likeable, alert: 'Unable to unlike this post.'
        end
    end

    private

    def find_likeable
        params.each do |name, value|
        if name =~ /(.+)_id$/
            return $1.classify.constantize.find(value)
        end
        end
        nil
    end

end
