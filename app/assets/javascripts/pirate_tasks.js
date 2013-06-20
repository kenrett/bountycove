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
    this.template = "<ul class='pirate_tasks_show'><h1>" +header+ "</h1>" +content+ "</ul>";
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

function TaskSuccess(elem, message) {
  this.elem = elem;
  this.message = message;
}

TaskSuccess.prototype = {
  renderToPage: function() {
    this.createTemplate(this.message);
    $(this.elem).html(this.template);
  },

  createTemplate: function(message) {
    this.template = "<div data-alert class='alert-box'>"+message+"<a href='#' class='close'>&times;</a></div>";
  }
}

$(document).ready(function(){

  $('#mid_nav_bar').on('ajax:success','#pirate_task_cove', function(e, data, status, xhr){

    var leftBox   = new List('.pirate.profile_left', 'New Tasks!', data.tasks_available);
    var rightBox  = new List('.pirate.profile_right', 'Current Tasks!', data.task_current);
    var botBox   = new List('.pirate.profile_bottom', '', data.tasks_completed);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();
  });

  //Add task
  $('.pirate.profile_right').on('ajax:success', '#new_task', function(e, data, status, xhr) {
    var creationMessage = new TaskSuccess('.error_max_task_limit', data.task_create);
    creationMessage.renderToPage();
    
    var leftBox   = new List('.pirate.profile_left', 'New Tasks!', data.tasks_need_verify);
    var rightBox  = new List('.pirate.profile_right', 'Enter new Task!', data.task_form);
    var botBox   = new List('.pirate.profile_bottom', '', data.tasks_on_board);

    // leftBox.renderToPage();
    // rightBox.renderToPage();
    botBox.renderToPage();

  //Errors on Add
}).on('ajax:error', '#new_task', function(e, data, status, xhr) {
  var validationError = new TaskError('.error_max_task_limit', data.responseText);
  validationError.renderToPage();
  });

  //Edit Task
  $('.pirate.profile_bottom').on('ajax:success', '#edit_task', function(e, data, status, xhr) {
    var rightBox = new List('.pirate.profile_right', 'Update Task!', data.task_form);
    rightBox.renderToPage();
  });

  //Refresh after Edit
  $('.pirate.profile_right').on('ajax:success','.edit_task', function(e, data, status, xhr){
    var leftBox   = new List('.pirate.profile_left', 'Task to be Verified', data.tasks_need_verify);
    var rightBox  = new List('.pirate.profile_right', 'Enter new Task!', data.task_form);
    var botBox   = new List('.pirate.profile_bottom', '', data.tasks_on_board);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();
  });
  
  //Task verified button
  $('.pirate.profile_left').on('ajax:success','#verified_task', function(e, data, status, xhr){
    var leftBox   = new List('.pirate.profile_left', 'Task to be Verified', data.tasks_need_verify);
    var rightBox  = new List('.pirate.profile_right', 'Enter new Task!', data.task_form);
    var botBox   = new List('.pirate.profile_bottom', '', data.tasks_on_board);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();
  });
});
