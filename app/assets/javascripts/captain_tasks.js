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
    this.template = "<ul class='captain_tasks_show'><h1>" +header+ "</h1>" +content+ "</ul>";
  }
}

$(document).ready(function(){

  $('.captain_task_cove').on('ajax:success', function(e, data, status, xhr){
    topBox    = new List('.captain_profile_treasures', 'Available Tasks', data.tasks_on_board);
    leftBox   = new List('.captain_profile_left', 'Assigned Tasks', data.tasks_assigned);
    rightBox  = new List('.captain_profile_right', 'Tasks to Verify', data.tasks_need_verify);
    botBox    = new List('.captain_profile_bottom', 'Last 5 Completed Tasks', data.tasks_completed);
    
    topBox.renderToPage();
    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();
  });//end on
  
});//end ready
