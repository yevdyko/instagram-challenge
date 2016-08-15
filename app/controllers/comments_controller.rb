class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :owned_comment, only: :destroy

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash.now[:alert] = t('comments.create.alert')
      render root_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:thoughts)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def owned_comment
    @comment = current_user.comments.find_by(id: params[:id])
    if @comment.nil?
      redirect_to root_path, alert: t('comments.owned_comment.alert')
    end
  end
end
