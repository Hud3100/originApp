class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    # @microposts = Micropost.all.order(created_at: :desc)
    @q = Micropost.ransack(params[:q])
    @microposts = @q.result(distinct: true)
  end

  def new
    @micropost = Micropost.new
    @micropost.images.build
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments
    @comment = @micropost.comments.new
    @image = @comment.images.new
  end

  def create
    @micropost = current_user.microposts.create(micropost_params)
    if @micropost.save
      flash[:success] = '投稿されました'
      redirect_to @micropost
    else
      flash[:warning] = '投稿に失敗しました'
      redirect_to microposts_path
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:title, :content, :budget, :car_name, images_attributes: [:img], category_ids: [])
  end
end
