$(function() {
  $('body').on("click", ".like", function(){
    var like = $(this);
    var url  = like.attr('value');
    alert(url);
    $.ajax({url: url}).done(function(data){
      if( data == "" ){
        //like.removeClass("btn-danger");
        //like.addClass("btn-info");
        //like.html("likes: " + data);
      }else{
        like.addClass("btn-danger");
        like.removeClass("btn-info");
        like.html("likes: " + data);
      }
    });
  });
});
