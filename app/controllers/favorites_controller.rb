class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(micropost_id: params[:micropost_id])
    favorite.save

    micropost = Micropost.find(params[:micropost_id])
    micropost.create_notification_favorite!(current_user)

    redirect_to micropost_path(id: params[:micropost_id])
  end

  def destroy
    favorite = Favorite.find_by(micropost_id: params[:micropost_id], user_id: current_user.id)
    favorite.destroy
    redirect_to micropost_path(id: params[:micropost_id])
  end
end