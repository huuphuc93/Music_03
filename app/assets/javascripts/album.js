$(document).ready(function(){
  $('.song-album li').first().addClass('song-is-chose')
  endedSong = function(){
    $song_id = $('.audio-player').data('id');
    $album_id = $('.rating-section').data('id');
    $fl_list_id = $('.rating-section').data('fl-id');
    $.ajax({
      method: 'POST',
      url: '/songs/next',
      data: {
        'song_id': $song_id,
        'album_id': $album_id,
        'favorite_list_id': $fl_list_id
      }
    })
  }
})