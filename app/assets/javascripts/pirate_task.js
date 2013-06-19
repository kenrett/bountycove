$(document).ready(function(){
  $(".accept_quest a").on("ajax:success", function(event, data, s, xhr){
    for (var x in data){
      $(".flash_message").html(data[x]);
    };
    $(this).closest('ul').remove();
  });
});
