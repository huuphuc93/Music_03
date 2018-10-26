$(document).ready(function(){
  $('.favorite-content').hide();
  $('.favorite-plus').on('click', function(){
    $('.favorite-content').toggle();
  });
});