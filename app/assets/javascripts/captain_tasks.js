function List(elem,title,content) {
  this.elem = elem;
  this.title = title;
  this.content = content;
}

List.prototype = {
  renderToPage: function() {
    this.renderTemplate(this.title,this.content);

    $(this.elem).html(this.template);
  },

  renderTemplate: function(header, content) {
    this.template = "<ul class='captain_tasks'><h1>" +header+ "</h1>" +content+ "</ul>";
  }
}

$(document).ready(function(){
  $('.captain_treasure_index').on('ajax:success', function(e, data, status, xhr){
    leftBox   = new List('.captain_profile_left', 'Available Tasks', data.tasks_on_board);
    rightBox  = new List('.captain_profile_right', 'Assigned Tasks', data.tasks_assigned);
    botBox    = new List('.treasures_delivered', 'Tasks to Verify', data.tasks_need_verify);
    
    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();
  });//end on
  
});//end ready
