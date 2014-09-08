function replaceVowels(){
  var new_poem = "";
  var vowels = ["A", "E", "I", "O", "U", "Y", "a", "e", "i", "o", "u", "y"];

  for(index = 0; index < poem.length; index++){
    if( vowels.indexOf(poem.charAt(index)) !== -1 ){
      new_poem = new_poem + "X";
    }
    else {
      new_poem = new_poem + poem[index];
    }
  }

  $("#replaced_poem").html(new_poem);
};



$(document).ready(function(){
  poem =  "<p>" +
          "Devoutly worshipping the oak</br>" +
          "Wherein the barred owl stares,</br>" +
          "The little feathered forest folk</br>" +
          "Are praying sleepy prayers.</br>" +
          "</p>" +
          "</br>" +
          "<p>" +
          "Praying the summer to be long</br>" +
          "And drowsy to the end,</br>" +
          "And daily full of sun and song,</br>" +
          "That broken hopes may mend.</br>" +
          "</p>"

  $("#original_poem").html(poem);

  var sports = "tennis,ice hockey,baseball,basketball,football,soccer,bowling";

  sports_array = sports.split(",");
  sports_array.sort();

  for(index in sports_array){
    $("#sports").append("<li>" + sports_array[index] + "</li>");
  }

});

//Testing git to see what happens when you push to master
