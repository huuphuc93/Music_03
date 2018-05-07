class SearchsController < ApplicationController
  def search
    @songs = SearchSongQuery.new params[:search]
    @results = @songs.search_songs
  end
end
