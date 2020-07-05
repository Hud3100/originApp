class UsersController < ApplicationController
  before_action :user_signed_in?, only: :show
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
  end
end
