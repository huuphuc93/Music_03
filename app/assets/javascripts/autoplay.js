$(document).ready(function(){
  var $checked_autoplay = true;
  autoplay()
  $('.switch').on('click', function(){
    $checked_autoplay = $("input[type='checkbox']")[0].checked;
    autoplay()
  });
  
  function autoplay (){
    if ($checked_autoplay != false) {
      $('.audio-song').on("ended");
      $('.audio-song').on('ended',function(){
        var recommend_id = $('.recommend-song').first().data("id");
        window.location = '/songs/' + recommend_id;
      });
    } else {
      $('.audio-song').off("ended");
    }
  }
});