class PostsController < ApplicationController
  before_action :set_post, only: [:show]
  def show    
  end
  def index
  end
  def new
    @post = Post.new
  end 
  def create
    @post = Post.new(post_params)
    if @post.save 
      redirect_to post_path(@post), notice: 'Post has been sucessfully created.'
    else 
      render :new
    end
  end
  private
  def set_post
    @post = Post.find(params[:id])
  end
  def post_params
    params.require(:post).permit(:date,:rationale)
  end
end
