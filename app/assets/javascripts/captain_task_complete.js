$(document).ready(function(){
  $("#fun").on("ajax:success", function(event, data, s, xhr){
    console.log(data);
    debugger;
    $(this).closest(parent).remove();
  });
});
