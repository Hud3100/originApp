class MicropostsController < ApplicationController
  def index
    @microposts = Micropost.all
  end

  def new
    @micropost = Micropost.new
    @micropost.images.build
  end

  def create
    @micropost = current_user.microposts.create(micropost_params)
    @micropost.save
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
