class RelationshipsController < ApplicationController
    before_action :authenticate_user!

    def create
        user = User.find(params[:followee_id])
        current_user.follow(user)
        redirect_back(fallback_location: root_path, notice: 'Followed successfully.')
    end

    def destroy
        user = Relationship.find(params[:id]).followee
        current_user.unfollow(user)
        redirect_back(fallback_location: root_path, notice: 'Unfollowed successfully.')
    end

end
