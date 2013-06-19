$(document).ready(function(){
  // Renders pirate account signup form for captain
  $('.captain.profile_left').on('ajax:success', '#add_pirate', function(e, data, status, xhr) {
    $('.captain.profile_right').html(data.sign_up_form);
  });//end on

  $('.captain.profile_right').on('ajax:success', '#add_pirate_form', function(e, data, status, xhr) {
    debugger;
  });
});//end ready
