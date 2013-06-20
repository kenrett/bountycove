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
    this.template = "<div data-alert class='alert alert-box'>"+message+"<a href='#' class='close'>&times;</a></div>";
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

  $('#mid_nav_bar').on('ajax:success','#captain_task_cove', function(e, data, status, xhr){

    var leftBox   = new List('.captain.profile_left', 'Task to be Verified', data.tasks_need_verify);
    var rightBox  = new List('.captain.profile_right', 'Create new Quest!', data.task_form);
    var botBox   = new List('.captain.profile_bottom', '', data.tasks_on_board);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();
  });

  //Add task
  $('.captain.profile_right').on('ajax:success', '#new_task', function(e, data, status, xhr) {

    var leftBox   = new List('.captain.profile_left', 'Task to be Verified', data.tasks_need_verify);
    var rightBox  = new List('.captain.profile_right', 'Create new Quest!', data.task_form);
    var botBox   = new List('.captain.profile_bottom', '', data.tasks_on_board);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();

  //Errors on Add
}).on('ajax:success', '#new_task', function(e, data, status, xhr) {
  var validationSuccess = new TaskSuccess('.error_max_task_limit', "Yer created a quest!");
  validationSuccess.renderToPage();
}).on('ajax:error', '#new_task', function(e, data, status, xhr) {
  var validationError = new TaskError('.error_max_task_limit', data.responseText);
  validationError.renderToPage();
});

  //Edit Task Get
  $('.captain.profile_bottom').on('ajax:success', '#edit_task', function(e, data, status, xhr) {
    var rightBox = new List('.captain.profile_right', 'Update Task!', data.task_form);
    rightBox.renderToPage();
  });

  //Refresh after Edit
  $('.captain.profile_right').on('ajax:success','.edit_task', function(e, data, status, xhr){
    var leftBox   = new List('.captain.profile_left', 'Task to be Verified', data.tasks_need_verify);
    var rightBox  = new List('.captain.profile_right', 'Create new Quest!', data.task_form);
    var botBox   = new List('.captain.profile_bottom', '', data.tasks_on_board);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();
  }).on('ajax:success', '.edit_task', function(e, data, status, xhr) {
    var validationSuccess = new TaskSuccess('.error_max_task_limit', "Yer Quest has been Edited");
    validationSuccess.renderToPage();
  });

  //Task verified button
  $('.captain.profile_left').on('ajax:success','#verified_task', function(e, data, status, xhr){
    var leftBox   = new List('.captain.profile_left', 'Task to be Verified', data.tasks_need_verify);
    var rightBox  = new List('.captain.profile_right', 'Create new Quest!', data.task_form);
    var botBox   = new List('.captain.profile_bottom', '', data.tasks_on_board);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();
  }).on('ajax:success', '#verified_task', function(e, data, status, xhr) {
    var validationSuccess = new TaskSuccess('#task_verify_message', "Yer Pirate has completed this Quest!");
    validationSuccess.renderToPage();
  });

  $('.captain.profile_right').on('ajax:success','#verified_task', function(e, data, status, xhr){
    var rightBox = new List('.captain.profile_right', 'Task to be Verified', data.tasks_need_verify);
    rightBox.renderToPage();
  }).on('ajax:success', '#verified_task', function(e, data, status, xhr) {
    var validationSuccess = new TaskSuccess('#task_verify_message', "Yer Pirate has completed this Quest!");
    validationSuccess.renderToPage();
  });

    // Delete Task
  $('.captain').on('ajax:success', '.delete_task', function(e, data, status, xhr) {
    $(this).closest('ul.task').remove();
    var deleteTask = new TreasureSuccess('#task_verify_message', data);
    deleteTask.renderToPage();
  });//end on

});
