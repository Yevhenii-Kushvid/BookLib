$(function() {
  $('body').on("click", ".like", function(){
    var like = $(this);
    var url  = like.attr('value');
    $.ajax({url: url}).done(function(data){
      if( data == "" ){
        like.removeClass("btn-danger");
        like.addClass("btn-info");
        var likes_amount = like.html().split(" ")[1];
        likes_amount = likes_amount - 1;
        like.html("likes: " + likes_amount);
      }else{
        like.addClass("btn-danger");
        like.removeClass("btn-info");
        like.html("likes: " + data);
      }
    });
  });
});
