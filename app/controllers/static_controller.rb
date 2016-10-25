class StaticController < ApplicationController
  def home
    @pending_posts = Post.where(:status => 'submitted' )
  end 
end