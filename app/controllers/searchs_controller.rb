class SearchsController < ApplicationController
  def search
    @results = Song.search_song(params[:search]).page(params[:page])
      .per Settings.paginate.page
    respond_to do |format|
      format.html
      format.js
    end
  end
end
