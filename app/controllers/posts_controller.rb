class PostsController < ApplicationController
  before_action :set_post, only: [:show,:edit,:update,:destroy,:approve]
 
  def show    
  end
  def index
    @posts = Post.posts_by(current_user).page(params[:page]).per(10)
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
    authorize @post
  end
  
  def destroy
    @post.delete
    redirect_to posts_path, notice: "Post was deleted."
  end 
  def update
    authorize @post
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'Post was updated.'
     else 
      render :edit
    end 
  end
  def approve
    authorize(@post)
    @post.approved!
    redirect_to root_path, notice: 'Post was approved'
  end 
  private
  def set_post
    @post = Post.find(params[:id])    
  end
  def post_params
    params.require(:post).permit(:date,:rationale,:status,:overtime_request)
  end
end
