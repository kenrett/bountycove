var close_box = false;

$(document).ready(function(){

  //Sign Up button show/hide (DRY up!)  
  $(".signup_button").on("click", function(){
  	var box = $(".sign_up")
  	if (box.is(":visible"))
  		box.fadeOut('fast');
  	else
  		box.fadeIn('fast');
  	return false;
  });
  
  $(".sign_up").hover(function(){
  	close_box=true;
  }, function(){
  	close_box=false;
  });
  
  $(document).click(function(){
  	if(! close_box)
  		$(".sign_up").fadeOut('fast');
  });

  //Login button show/hide (DRY up!)  
  $(".login_button").on("click", function(){
  	var box = $(".login")
  	if (box.is(":visible"))
  		box.fadeOut('fast');
  	else
  		box.fadeIn('fast');
  	return false;
  });
  
  $(".login").hover(function(){
  	close_box=true;
  }, function(){
  	close_box=false;
  });
  
  $(document).click(function(){
  	if(! close_box)
  		$(".login").fadeOut('fast');
  });
});