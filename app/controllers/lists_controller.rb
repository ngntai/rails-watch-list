class ListsController < ApplicationController

  before_action :set_list, only: [:show]
  def index
    @lists = List.all

  end

  def show
    bookmarks = Bookmark.where("list_id = #{params[:id]}")
    @hash_array = []
    bookmarks.each do |bookmark|
      @hash_array << {movie: Movie.find(bookmark[:movie_id]), comment: bookmark.comment, bookmark_id: bookmark.id}
    end
    @bookmark = Bookmark.new
    @reviews = Review.where("list_id = #{params[:id]}")
    @review = Review.new
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
