/*

example of function

window.my_function = function() {
  var email, html, password;
  email = $("#user_email").val();
  password = $("#user_password").val();
  html = email + " " + password;
  alert(session_path(resource_name));
  return $.post({
    url: "/resource/sign_in"
  }).done(function() {
    return alert('wow');
  });
};
*/
/*
$(document).ready(function(){
  $("body").on("click", ".output", function(){
    var email = "pathfinder1994@mail.ru";
    var password= "11111111";

    $.ajax({url: "/users/sign_in", type: "GET", data: {
      email: email,
      password: password,
      remember_me: false
    }}).done(function(data){
      alert();
    });
  });
});
/* POST запрос для того чтобы залогинится на сайте

utf8=✓
&authenticity_token=Y2oyWmjG3jN6WzraRBjXzqg7ugQTvc6U7QQxkNoP9xIs0oOflZRrfdEbg6boP43j%2BxR7Q370FA2WGSZOlWQoCg%3D%3D
user[email]=pathfinder404@gmail.com
user[password]=11111111
user[remember_me]=0
commit=Log in
*/
