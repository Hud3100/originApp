class MicropostsController < ApplicationController
  def index
    @microposts = Micropost.all
  end

  def new
    @micropost = current_user.microposts.new
  end

  def create
    @micropost = current_user.microposts.create(micropost_params)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
