function addPlace(){
  place = prompt("Where do you want to go?");
  list.push(place)
  outputArray(list)
};

function alphabetize(){
  list.sort()
  outputArray(list)
};

function removeLast(){
  list.pop();
  outputArray(list);
}

function removeItem(index){
  list.splice(index, 1);
  outputArray(list);
}

function outputArray(array){
  $("#places").html("")
  for(index in array) {
    $("#places").append("<li id=" + index + ">" + array[index] + "<input type='button' value='remove' onclick=removeItem(" + index + ")> </li>");
  }
};

$( document ).ready(function() {
  list = ["Virgin Islands", "Grenada", "Solomon Islands", "Bora Bora"];
  outputArray(list)
});
