$(document).ready(function(){
  $(".task_button").on("ajax:success", function(e, d, s, x){
    $(".captain_task").html(d.form).fadeIn('fast');
  });
});
