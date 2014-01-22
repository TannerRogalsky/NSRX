class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

	# In real life, we'd have sessions and some form of authentication
	# For now let's just auto-find-or-create and update any info we get

  def create
  	@user = User.find_or_create_by(:username => params[:username])
  	@user.update_kik_user_info!(params)

    score = params[:score].to_i
    @user.update_attributes!(:record => score) if score > @user.record
  end

  # A poor man's leaderboard

  def index
  	@users = User.order(:record => :desc)
  end


end

