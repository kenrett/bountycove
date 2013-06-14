$(document).ready(function(){

  $(".sign_up form").on('ajax:error', function(event, data){
    $('.error').html(data.responseText);
  });//end on ajax:error

  $(".sign_up form").on('ajax:success', function(event, data){
    window.location.href = data;  
  });//end on ajax:success
  
});//end ready
