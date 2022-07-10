class Public::GenresController < ApplicationController
  
  def show
    @ganres = Genre.all
    @ganre = Genre.find(params[:id])
    @items = Item.where(genre_id: params[:id]).page(params[:page])
  end
  
end
