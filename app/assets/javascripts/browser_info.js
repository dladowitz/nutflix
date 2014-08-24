

$(document).ready(function(){
  $("#browser").append("<li><strong>Name: </strong>" + navigator.appName + "</li>");
  $("#browser").append("<li><strong>Code Name:</strong> " + navigator.appCodeName + "</li>");
  $("#browser").append("<li><strong>Version: </strong>" + navigator.appVersion + "</li>");
  $("#browser").append("<li><strong>Cookies?: </strong>" + navigator.cookieEnabled + "</li>");

  window.moveTo(100,50);
  window.resizeTo(300,300);

  $("#browser").append("<li><strong>Height: </strong>" + window.innerHeight + "</li>");
  $("#browser").append("<li><strong>Width: </strong>" + window.innerWidth + "</li>");
});
