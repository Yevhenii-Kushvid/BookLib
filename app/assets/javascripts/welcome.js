$(function() {
  $("body").on("click",".close", function(){
    $(".modal-footer").html("");
  });

  $("body").html("dfsdfasdfasdfsdfsdfsdfsd");

  return $("form#sign_in_user, form#sign_up_user").bind("ajax:success", function(event, xhr, settings) {

    alert("good");

    $.ajax({url: "/"}).done(function(data){
      $("body").html(data);
    });

    return $(this).parents('.modal').modal('hide');

  }).bind("ajax:error", function(event, xhr, settings, exceptions) {
    $(".modal-footer").html("");

    var error_messages;

    error_messages = xhr.responseJSON['error'] ? "<div class='alert alert-danger pull-left'>" + xhr.responseJSON['error'] + "</div>" : xhr.responseJSON['errors'] ? $.map(xhr.responseJSON["errors"], function(v, k) {
      return "<div class='alert alert-danger pull-left'>" + k + " " + v + "</div>";
    }).join("") : "<div class='alert alert-danger pull-left'>Unknown error</div>";

    $(".modal-footer").html(error_messages);
    return $(this).parents('.modal').children('.modal-footer').html(error_messages);

  });
});
