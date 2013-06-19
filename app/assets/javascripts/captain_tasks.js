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
  function TaskError(elem, message) {
  this.elem = elem;
  this.message = message;
}

TaskError.prototype = {
  renderToPage: function() {
    this.createTemplate(this.message);
    $(this.elem).html(this.template);
  },

  createTemplate: function(message) {
    this.template = "<div data-alert class='alert-box'>"+message+"<a href='#' class='close'>&times;</a></div>";
  }

}

$(document).ready(function(){

  $('#mid_nav_bar').on('ajax:success','#captain_task_cove', function(e, data, status, xhr){

    leftBox   = new List('.captain_profile_left', 'Task to be Verified', data.tasks_need_verify);
    rightBox  = new List('.captain_profile_right', 'Enter new Task!', data.task_form);
    botBox   = new List('.captain_profile_bottom', '', data.tasks_on_board);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();

  });//end on

    $('.captain_profile_right').on('ajax:success', '.new_task#new_task', function(e, data, status, xhr) {
    if (data.error)
      {
        var taskError = new TaskError('.error_max_task_limit', data.error);
        taskError.renderToPage();
      }
    else if(data.update)
      {
        location.reload();
      }
    });
});//end ready
