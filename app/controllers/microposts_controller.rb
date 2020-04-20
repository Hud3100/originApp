class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @microposts = Micropost.all
  end

  def new
    @micropost = Micropost.new
    @micropost.images.build
  end

  def create
    @micropost = current_user.microposts.create(micropost_params)
    if @micropost.save
      flash[:success] = '投稿されました'
      redirect_to microposts_path
    else
      flash[:warning] = '投稿に失敗しました'
      render :new
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :budget, :car_name,
    images_attributes: [:img])
  end
end
