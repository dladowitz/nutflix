function validFirst(){
  value = ($("#first")[0].value)

  if(value == null || value == ""){
    $("#firstError").html("<span id=firstError style=color:red>Required Field</span>")
    $("#first")[0].style.backgroundColor ="red"
  } else if ( value.length < 3 ) {
    $("#firstError").html("<span id=firstError style=color:yellow>Response Too Short</span>")
    $("#first")[0].style.backgroundColor ="yellow"
  } else {
    $("#firstError").html("")
    $("#first")[0].style.backgroundColor ="white"
  }
}


function validLast(){
  value = ($("#last")[0].value)

  if(value == null || value == ""){
    $("#lastError").html("<span id=lastError style=color:red>Required Field</span>")
    $("#last")[0].style.backgroundColor ="red"
  } else if ( value.length < 3 ) {
    $("#lastError").html("<span id=lastError style=color:yellow>Response Too Short</span>")
    $("#last")[0].style.backgroundColor ="yellow"
  } else {
    $("#lastError").html("")
    $("#last")[0].style.backgroundColor ="white"
  }
}
