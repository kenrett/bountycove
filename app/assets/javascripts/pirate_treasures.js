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
  $('#mid_nav_bar').on('ajax:success', '#pirate_treasure_cove', function(e, data, status, xhr) {
    alert('yeah');
    debugger;
  });
});//end ready
