var Tax = {
  rate: 0,

  calculatePrice: function(price) {
    return Math.round(price + price*(this.rate/100));
  }
};

function Treasure(elem, treasure) {
  this.elem = elem;
  this.captain = window.location.pathname.split('/').pop();
  this.treasureId = treasure.id;
  this.name = treasure.name;
  this.imgSRC = "http://us.cdn1.123rf.com/168nwm/orla/orla1010/orla101000044/8041795-wooden-treasure-chest-with-gold-coins-printed-with-royal-crown--3d-render.jpg";
}

Treasure.prototype = {
  renderToPage: function() {
    $(this.elem).append(this.createTemplate());
  },

  createTemplate: function() {
    this.template = "<div class='large-3 columns treasure_item'><img src='" +this.imgSRC+ "' /><br />" +
                       "<a href='/captains/" +this.captain+ "/treasures/" +this.treasureId+ "' class='captain_treasure_show' data-remote='true'>" +this.name+ "</a></div><div class='large-1 columns'></div>";
    return this.template;
  }
};

function List(elem, title, content) {
  this.elem = elem;
  this.title = title;
  this.content = content;
}

List.prototype = {
  renderToPage: function() {
    this.createTemplate(this.title,this.content);

    $(this.elem).html(this.template);
  },

  createTemplate: function(header, content) {
    this.template = "<ul class='treasures_on_sale'><h1>" +header+ "</h1>" +content+ "</ul>";
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

function addCommas(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }

    return x1 + x2;
  }

$(document).ready(function(){
  // Clicking "Treasure Cove" to render treasure view
  $('#mid_nav_bar').on('ajax:success', '#captain_treasure_cove', function(e, data, status, xhr){
    var leftBox  = new List('.captain.profile_left', 'Treasure to deliver', data.treasures_bought);
    var rightBox = new List('.captain.profile_right', 'Add Treasures!', data.new_treasure_form);
    var botBox   = new List('.captain.profile_bottom', 'Treasure delivered', data.treasures_delivered);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();

    Tax.rate = data.tax_rate;
  });//end on for rendering treasure profile view

  // Adding a new treasure
  $('.captain.profile_right').on('ajax:success', '.new_treasure', function(e, data, status, xhr) {
    $('.captain.profile_main div').html(data.treasure_board);
    var creationMessage = new TreasureSuccess('.error_max_treasure_limit', data.success_creation);
    creationMessage.renderToPage();
  }).on('ajax:error', '#new_treasure', function(e, data, status, xhr) {
    var error = '';
    data.responseJSON.forEach(function(value, index) {
      error += "<li>" +value+ "</li>";
    });
    updateError = new TreasureError('.error_max_treasure_limit', error.trim());
    updateError.renderToPage();
  });//end on

  // Editing a treasure
  $('.captain.profile_right').on('ajax:success', '.edit_treasure', function(e, data, status, xhr) {
    $('.captain.profile_main').html(data.treasure_board);

    var rightBox = new List('.captain.profile_right', 'Add Treasures!', data.new_treasure_form);
    rightBox.renderToPage();

    var editMessage = new TreasureSuccess('.error_max_treasure_limit', data.success_message);
    editMessage.renderToPage();
  }).on('ajax:error', '.edit_treasure', function(e, data, status, xhr) {
    var error = '';
    data.responseJSON.forEach(function(value, index) {
      error += "<li>" +value+ "</li>";
    });
    updateError = new TreasureError('.error_max_treasure_limit', error.trim());
    updateError.renderToPage();
  });// end on

  // Showing treasure to edit when clicked
  $('.captain.profile_main').on('ajax:success', '.captain_treasure_show', function(e, data, status, xhr) {
    $('.captain.treasure_show').removeClass('active');
    $(this).addClass('captain_treasure_show active');

    var leftBox  = new List('.captain.profile_left', 'Treasure to deliver', data.treasures_bought);
    var rightBox = new List('.captain.profile_right', 'Edit Treasure!', data.new_treasure_form);
    var botBox   = new List('.captain.profile_bottom', 'Treasure delivered', data.treasures_delivered);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();

    Tax.rate = data.tax_rate;
  });//end on

  // Delivering treasure
  $('.captain.profile_left').on('ajax:success', 'a#deliver-treasure', function(e, data, status, xhr) {
    var leftBox  = new List('.captain.profile_left', 'Treasure to deliver', data.treasures_to_deliver);
    var botBox   = new List('.captain.profile_bottom', 'Treasure delivered', data.treasures_delivered);

    leftBox.renderToPage();
    botBox.renderToPage();

    var deliverMessage = new TreasureSuccess('#deliver_message', data.success_message);
    deliverMessage.renderToPage();
  });//end on

  // Dynamically add up the total price
  $('.captain.profile_right').on('keyup', '#treasure_price', function(e) {
      var price = parseFloat(e.target.value);
      var total = addCommas(Tax.calculatePrice(price));
      $('#total_price').html(total);
    });//end on

  // Delete treasure
  $('.captain.profile_main').on('ajax:success', '.delete_treasure', function(e, data, status, xhr) {
    $(this).closest('div').remove();
    var deleteTreasure = new TreasureSuccess('#treasure_message', data);
    deleteTreasure.renderToPage();
  });//end on
});//end ready
