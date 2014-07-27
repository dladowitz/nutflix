class RelationshipsController < ApplicationController
  before_filter :require_user

  def index
    @relationships = current_user.followed_user_relationships
  end

  def create
    followed_user = User.find params[:followed_user_id]
    followed_users = current_user.followed_users

    if followed_user == current_user
      flash[:danger] = "Naw brah, you can't be following yourself now."
    elsif followed_users.include?(followed_user)
      flash[:error] = "Ain't no double dipping going on round here"
    else
      relationship = Relationship.new(followed_user: followed_user, follower: current_user)

      if relationship.save
        flash[:success] = "You're now stalking #{followed_user.full_name}"
      end
    end

    redirect_to user_path followed_user
  end

  def destroy
    relationship = Relationship.find params[:id]
    relationship.delete

    redirect_to people_path
  end
end
