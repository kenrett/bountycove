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
  // Renders pirate account signup form for captain
  $('.captain.profile_left').on('ajax:success', '#add_pirate', function(e, data, status, xhr) {
    $('.captain.profile_right').html(data.sign_up_form);
  });//end on

  // Add new pirate accounts for captain
  $('.captain.profile_right').on('ajax:success', '#new_pirate', function(e, data, status, xhr) {
    $('.captain.profile_left div.row').html(data.list_of_pirates);
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
