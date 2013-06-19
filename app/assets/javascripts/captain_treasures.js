var Tax = {
  rate: 0,

  calculatePrice: function(price) {
    return Math.round(price + price*(this.rate/100));
  }
}

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
    return this.template = "<div class='large-3 columns treasure_item'><img src='" +this.imgSRC+ "' /><br />" +
                       "<a href='/captains/" +this.captain+ "/treasures/" +this.treasureId+ "' class='captain_treasure_show' data-remote='true'>" +this.name+ "</a></div><div class='large-1 columns'></div>";
  }
}

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
}

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
}

$(document).ready(function(){
  // Clicking "Treasure Cove" to render treasure view
  $('#captain_treasure_cove').on('ajax:success', function(e, data, status, xhr){
    var leftBox  = new List('.captain_profile_left', 'Treasure to deliver', data.treasures_bought);
    var rightBox = new List('.captain_profile_right', 'Add Treasures!', data.new_treasure_form);
    var botBox   = new List('.captain_profile_bottom', 'Treasure delivered', data.treasures_delivered);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();

    Tax.rate = data.tax_rate;
  });//end on for rendering treasure profile view

  // Adding a new treasure
  $('.captain_profile_right').on('ajax:success', '#new_treasure', function(e, data, status, xhr) {
    $('.captain_profile_main').html(data.treasure_board);
  });

  $('.captain_profile_right').on('ajax:error', '#new_treasure', function(e, data, status, xhr) {
    var validationError = new TreasureError('.error_max_treasure_limit', data.responseText);
    validationError.renderToPage();
  });

  $('.captain_profile_right').on('ajax:success', '.edit_treasure', function(e, data, status, xhr) {
    $('.captain_profile_main').html(data.treasure_board);
  });

  // Showing treasure when clicked
  $('.captain_treasure_show').on('ajax:success', function(e, data, status, xhr) {
    $('.captain_treasure_show').removeClass('active');
    $(this).addClass('captain_treasure_show active');

    var leftBox  = new List('.captain_profile_left', 'Treasure to deliver', data.treasures_bought);
    var rightBox = new List('.captain_profile_right', 'Edit Treasure!', data.new_treasure_form);
    var botBox   = new List('.captain_profile_bottom', 'Treasure delivered', data.treasures_delivered);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();

    Tax.rate = data.tax_rate;
  });//end on for editting treasure

  // Dynamically add up the total price
  $('.captain_profile_right').on('keyup', '#treasure_price', function(e) {
      var price = parseFloat(e.target.value);
      $('#total_price').html(Tax.calculatePrice(price));
    });//end on for dynamic addition of total price
});//end ready
