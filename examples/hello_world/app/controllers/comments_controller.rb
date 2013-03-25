class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post.comments << Comment.new(params[:comment])
    @post.save
    redirect_to post_path(@post)
  end
  
    
end