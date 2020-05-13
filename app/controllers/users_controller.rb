class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @favorite_microposts = @user.favorite_microposts
  end
end
