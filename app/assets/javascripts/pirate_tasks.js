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
    
    var leftBox   = new List('.pirate.profile_left', 'Current Tasks!', data.tasks_assigned);
    var rightBox  = new List('.pirate.profile_right', '', data.task_highlight);
    var botBox    = new List('.pirate.profile_bottom', '', data.tasks_on_board);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();
  });

  //Accept task
  $('.pirate.profile_bottom').on('ajax:success', '.accept_quest', function(e, data, status, xhr) {
    
    var leftBox   = new List('.pirate.profile_left', 'Current Tasks!', data.tasks_assigned);
    var rightBox  = new List('.pirate.profile_right', '', data.task_highlight);
    var botBox    = new List('.pirate.profile_bottom', '', data.tasks_on_board);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();

  //Errors on Add
}).on('ajax:error', '.accept_quest', function(e, data, status, xhr) {
  var validationError = new TaskError('#task_available_message', data.responseText);
  validationError.renderToPage();
  });

  //Complete Task
$('.pirate.profile_left').on('ajax:success', '#pirate_complete', function(e, data, status, xhr) {
    
    var leftBox   = new List('.pirate.profile_left', 'Current Tasks!', data.tasks_assigned);
    var rightBox  = new List('.pirate.profile_right', '', data.task_highlight);
    var botBox    = new List('.pirate.profile_bottom', '', data.tasks_on_board);

    leftBox.renderToPage();
    rightBox.renderToPage();
    botBox.renderToPage();
  });

$('.pirate.profile_right').on('ajax:success','.accept_prof_quest', function(e, data, status, xhr){
    $(this).closest('ul').remove();
    
    var validationSuccess = new TaskSuccess('#quest_accepted', "Arrrghh you've cast off on a Quest!");
    validationSuccess.renderToPage();
});

$('.pirate').on('ajax:success', '#show_task', function(e, data, status, xhr) {
    var rightBox  = new List('.pirate.profile_right', '', data.task_highlight);
    rightBox.renderToPage();
  });

});
