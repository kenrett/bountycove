$(document).ready(function(){

  $(".sign_up form").on('ajax:error', function(event, data, error){
    $('.error').html(data.responseText);
  });//end on ajax:error

  $(".sign_up form").on('ajax:success', function(status, data, xhr){
    window.location.href = data;
  });//end on ajax:success

});//end ready
