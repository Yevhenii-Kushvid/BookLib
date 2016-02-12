# example of function
window.my_function = () ->
  email = $("#user_email").val()
  password = $("#user_password").val()

  html = email + " " + password

  alert session_path(resource_name)
  $.post(url: "/resource/sign_in").done ->
    alert('wow');
