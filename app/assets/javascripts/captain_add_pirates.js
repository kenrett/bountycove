function PirateError(elem, message) {
  this.elem = elem;
  this.message = message;
}

PirateError.prototype = {
  renderToPage: function() {
    this.createTemplate(this.message);
    $(this.elem).html(this.template);
  },

  createTemplate: function(message) {
    this.template = "<div data-alert class='alert alert-box'><ul>"+message+"</ul><a href='#' class='close'>&times;</a></div>";
  }
};

function PirateSuccess(elem, message) {
  this.elem = elem;
  this.message = message;
}

PirateSuccess.prototype = {
  renderToPage: function() {
    this.createTemplate(this.message);
    $(this.elem).html(this.template);
  },

  createTemplate: function(message) {
    this.template = "<div data-alert class='alert-box'>"+message+"<a href='#' class='close'>&times;</a></div>";
  }
};

$(document).ready(function() {
  // Renders pirate page
  $('#mid_nav_bar').on('ajax:success', '#captain_pirates_cove', function(e, data, status, xhr) {
    $('.captain.profile_left').html(data.list_of_pirates);
    $('.captain.profile_left').append('<a href="/captains/c/pirates/new" data-remote="true" id="add_pirate">Add Pirate</a>');
    $('.captain.profile_right').html(data.sign_up_form);
    $('.captain.profile_bottom').html('');
  });

  // Edit a pirate account
  $('.captain.profile_right').on('ajax:success', '.edit_pirate', function(e, data, status, xhr) {
    $('.captain.profile_left').html(data.list_of_pirates);
    $('.captain.profile_left').append('<a href="/captains/c/pirates/new" data-remote="true" id="add_pirate">Add Pirate</a>');
    $('.captain.profile_right').html(data.sign_up_form);
    $('.captain.profile_bottom').html('');

    var pirateSuccessMessage = new PirateSuccess('#new_pirate_message', data.success_message);
    pirateSuccessMessage.renderToPage();
  }).on('ajax:error', '.edit_pirate', function(e, data, status, xhr) {
    var error = '';
    data.responseJSON.forEach(function(value, index) {
      error += "<li>" +value+ "</li>";
    });
    editError = new PirateError('#new_pirate_message', error.trim());
    editError.renderToPage();
  });


  // Renders pirate account signup form for captain
  $('.captain.profile_left').on('ajax:success', '#add_pirate', function(e, data, status, xhr) {
    $('.captain.profile_right').html(data.sign_up_form);
  });//end on

  // Render pirate acct edit form when pirate is clicked on
  $('.captain.profile_left').on('ajax:success', '#edit_pirate_acct', function(e, data, status, xhr) {
    $('.captain.profile_right').html(data.pirate_edit_form);
    $('.captain.profile_bottom').html('');
  });

  // Add new pirate accounts for captain
  $('.captain.profile_right').on('ajax:success', '#new_pirate', function(e, data, status, xhr) {
    $('.captain.profile_left').html(data.list_of_pirates);
    $('.captain.profile_left').append('<a href="/captains/c/pirates/new" data-remote="true" id="add_pirate">Add Pirate</a>');
    $('.captain.profile_right').html(data.sign_up_form);

    var pirateSuccessMessage = new PirateSuccess('.captain.profile_right #new_pirate_message', data.success_message);
    pirateSuccessMessage.renderToPage();
  }).on('ajax:error', '#new_pirate', function(e, data, status, xhr) {
    var error = '';
    data.responseJSON.forEach(function(value, index) {
      error += "<li>" +value+ "</li>";
    });
    signUpError = new PirateError('#new_pirate_message', error.trim());
    signUpError.renderToPage();
  });

});//end ready
