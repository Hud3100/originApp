class CommentsController < ApplicationController
  def create
    micropost = Micropost.find(params[:micropost_id])
    @comment = micropost.comments.build(comment_params)
    @comment.company_id = current_company.id
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      flash[:warning] = '投稿に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
