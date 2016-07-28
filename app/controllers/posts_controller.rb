class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Your post has been created."
      redirect_to root_path
    else
      flash[:alert] = "Warning! You need an image to post here!"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated successfully."
      redirect_to root_path
    else
      flash[:alert] = "Update failed. Please check the form."
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Post deleted successfully."
      redirect_to root_path
    else
      flash[:alert] = "Delete failed. Please check the form."
      render :edit
    end
  end

  def like
    if @post.liked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :description)
  end

  def owned_post
    @post = current_user.posts.find_by(id: params[:id])
    if @post.nil?
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
