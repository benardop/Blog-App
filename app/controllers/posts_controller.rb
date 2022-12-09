class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
  end

  def show
    @post = Post.find_by(id: params[:post_id])
  end

  def new
    @current = current_user
  end

  def create
    new_post = current_user.posts.build(post_params)

    respond_to do |format|
      format.html do
        if new_post.save
          redirect_to user_post_path(new_post.author_id, new_post.id), notice: 'Post created successfully'
        else
          render :new, alert: 'Post is not created. Please try again!'
        end
      end
    end
  end
end
