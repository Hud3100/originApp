class CommentsController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    if @comment.save
      if current_user
        @comment.commentable_id = current_user.id
        @micropost.create_notification_comment_for_user!(current_user, @comment.id, "user")
      elsif current_company
        @comment.commentable_id = current_company.id
        @micropost.create_notification_comment!(current_company, @comment.id, "company")
      end
      flash[:success] = 'コメントが投稿されました。'
      redirect_to @micropost
      # redirect_back(fallback_location: root_path)
    else
      render 'microposts/show', { micropost: @micropost }
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:title, :content, :commentable_type, :commentable_id, images_attributes: [:id, :img, :_destroy])
  end
end
