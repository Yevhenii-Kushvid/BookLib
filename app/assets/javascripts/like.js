$(function() {
  $('body').on("click", ".like", function(){
    var like = $(this);
    var url  = like.attr('value');
    $.ajax({url: url}).done(function(data){
      if( data == "" ){}else{
        like.addClass("btn-danger");
        like.removeClass("btn-info");
        like.html("likes: " + data);
      }
    });
  });
});
