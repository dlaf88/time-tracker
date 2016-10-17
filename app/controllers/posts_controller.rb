class PostsController < ApplicationController
  before_action :set_post, only: [:show,:edit,:update,:destroy]
 
  def show    
  end
  def index
    @posts = Post.all
  end
  def new
    @post = Post.new
  end 
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save        
      redirect_to post_path(@post), notice: 'Post has been sucessfully created.'
    else 
      render :new
    end
  end
  def edit
    
  end
  
  def destroy
    @post.delete
    redirect_to posts_path, notice: "Post was deleted."
  end 
  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'Post was updated.'
     else 
      render :edit
    end 
  end
  private
  def set_post
    @post = Post.find(params[:id])    
  end
  def post_params
    params.require(:post).permit(:date,:rationale,:status)
  end
end
