var Tax = {
  rate: 0,

  calculatePrice: function(price) {
    return Math.round(price + price*(this.rate/100));
  }
};

function TreasureError(elem, message) {
  this.elem = elem;
  this.message = message;
}

TreasureError.prototype = {
  renderToPage: function() {
    this.createTemplate(this.message);
    $(this.elem).html(this.template);
  },

  createTemplate: function(message) {
    this.template = "<div data-alert class='alert alert-box'>"+message+"<a href='#' class='close'>&times;</a></div>";
  }
};

function TreasureSuccess(elem, message) {
  this.elem = elem;
  this.message = message;
}

TreasureSuccess.prototype = {
  renderToPage: function() {
    this.createTemplate(this.message);
    $(this.elem).html(this.template);
  },

  createTemplate: function(message) {
    this.template = "<div data-alert class='alert-box'>"+message+"<a href='#' class='close'>&times;</a></div>";
  }
};

$(document).ready(function(){
  // Render treasure view for pirate
  $('#mid_nav_bar').on('ajax:success', '#pirate_treasure_cove', function(e, data, status, xhr) {
    $('.pirate.profile_left').html(data.t_purchased);
    $('.pirate.profile_right').html(data.t_received);
  });

  // Buy treasure from treasure board
  $('.pirate.profile_main').on('ajax:success', '#buy_treasure', function(e, data, status, xhr) {
    $(this).closest('div').remove();
    $('.pirate.profile_left').html(data.t_purchased);
    $('.pirate.profile_right').html(data.t_received);

    var treasureBought = new TreasureSuccess('#treasure_message', data.success_message);
    treasureBought.renderToPage();
  }).on('ajax:error', '#buy_treasure', function(e, data, status, xhr) {
    var treasureBought = new TreasureError('#treasure_message', data.responseText);
    treasureBought.renderToPage();
  });
});//end ready
