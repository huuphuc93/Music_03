class CommentsController < ApplicationController
  def create
    @comment = Comment.new comment_params
    @comment.user = current_user
    
  end

  def update
  end

  def delete
  end
  
  private
  
  def comment_params
    params.require(:comment).permit :content, :commentable_id  
  end
end
