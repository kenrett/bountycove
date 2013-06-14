$(document).ready(function(){

  $(".login form").on('ajax:error', function(event, login_info){
    $(".error_login").html(login_info.responseText);
  });//end on ajax:error
  
  $(".login form").on('ajax:success', function(event, login_info){
    window.location.href = login_info;
  });//end on ajax:success
  
});//end ready
