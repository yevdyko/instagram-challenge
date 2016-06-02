class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = "Your comment has been added."
      redirect_to posts_path
    else
      flash[:alert] = "Check the comment form. Something went wrong."
      render root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:thoughts)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
