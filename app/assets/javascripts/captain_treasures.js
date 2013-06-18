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
    this.createTemplate('Error', this.message);
    $(this.elem).html(this.template);
  },

  createTemplate: function(message) {
    this.template = "<div data-alert class='alert-box'>"+message+"<a href='#' class='close'>&times;</a></div>";
  } 
}

$(document).ready(function(){
  // Clicking "Treasure Cove" to render treasure view
  $('.captain_treasure_index').on('ajax:success', function(e, data, status, xhr){
    leftBox  = new List('.captain_profile_left', 'Treasure bought', data.treasures_bought);
    rightBox = new List('.captain_profile_right', 'Add Treasures!', data.new_treasure_form);
    botBox    = new List('.treasures_delivered', 'Treasure delivered', data.treasures_delivered);
    
    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();
  });//end on

  // Adding a new treasure
  $('.captain_profile_right').on('ajax:success', 'form', function(e, data, status, xhr) {
    if (data.error) {
      treasureError = new TreasureError('.error_max_treasure_limit', data.error);
      treasureError.renderToPage();
    }
    else {

    }
  });//end adding new treasure
});//end ready
