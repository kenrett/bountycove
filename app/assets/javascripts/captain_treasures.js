function List(elem,title,content) {
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

$(document).ready(function(){
  $('.captain_treasure_index').on('ajax:success', function(e, data, status, xhr){
    leftBox  = new List('.captain_profile_left', 'Treasure bought', data.treasures_bought);
    rightBox = new List('.captain_profile_right', 'Add Treasures!', data.new_treasure_form);
    botBox    = new List('.treasures_delivered', 'Treasure delivered', data.treasures_delivered);
    
    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();
  });//end on
});//end ready
