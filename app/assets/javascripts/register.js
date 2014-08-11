$(document).ready(function(){
  $( "#signup-free-subscription" ).click(function() {
    $("#free").toggle();
    $("#premium").toggle();
    $("#signup-free-subscription").toggle();
    $("#signup-premium-subscription").toggle();
  });

  $( "#signup-premium-subscription" ).click(function() {
    $("#free").toggle();
    $("#premium").toggle();
    $("#signup-free-subscription").toggle();
    $("#signup-premium-subscription").toggle();
  });
});

