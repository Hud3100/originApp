class UsersController < ApplicationController
  before_action :user_signed_in?, only: :show
  def show
    @user = User.find(params[:id])
    @microposts = Micropost.find_by(user_id: @user.id)
    @favorite_microposts = @user.favorite_microposts
  end
end
