class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(user_id: params[:user_id]) # Use `new` instead of `build`

    if @like.save
      redirect_to user_post_path(user_id: current_user.id, id: @post.id), notice: 'Post liked successfully.'
    else
      redirect_to user_post_path(user_id: current_user.id, id: @post.id), alert: 'Post not liked'
    end
  end
end
