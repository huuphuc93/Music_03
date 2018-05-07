$(document).ready(function(){
  var checked_autoplay = true;
  $('.switch').on('change', function(){
    checked_autoplay = $("input[type='checkbox']")[0].checked;
  });
  if (checked_autoplay != false) {
    $('.audio-song').on('ended',function(){
      var recommend_id = $('.recommend-song').first().data("id");
      window.location = '/songs/' + recommend_id;
    });
  }
});