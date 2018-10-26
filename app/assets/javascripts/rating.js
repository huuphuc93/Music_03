$(document).ready(function(){
  var $star_rating = $('.star-rating .fa');

  var SetRatingStar = function() {
    return $star_rating.each(function() {
      if (parseInt($star_rating.siblings('input.rating-value').val()) >= parseInt($(this).data('rating'))) {
        return $(this).removeClass('fa-star-o').addClass('fa-star');
      } else {
        return $(this).removeClass('fa-star').addClass('fa-star-o');
      }
    });
  };
  
  $star_rating.on('click', function() {
    $star_rating.siblings('input.rating-value').val($(this).data('rating'));
    return SetRatingStar();
  });
  
  SetRatingStar();
  
  $star_rating.on('click', function(){
    var point = $('.rating-value').val();
    var ratable_id = $('.rating-section').data("id") || $('.rating-section').data("fl-id") ;
    var ratable_type = $('.rating-section').data("type");
    $.ajax({
      method: 'POST',
      url: '/ratings',
      data: {'rating': {
        'point': point,
        'ratable_id': ratable_id,
        'ratable_type': ratable_type
      }},
      dataType: 'JSON'
    }).done(function(data){
      if(data.status == 'success'){
        alert(I18n.t("flash.rating_success"));
      } else {
        alert(I18n.t("flash.please_login"));
      }
    })
  })
});