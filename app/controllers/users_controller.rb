class UsersController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.retrieve_recent_posts
  end
end
