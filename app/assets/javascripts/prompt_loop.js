var answer = ""

document.write("<h2>Superteam: </h2>")

while(answer != "stop"){
  answer = prompt("Who would make superhero team?")
  if(answer != "stop"){
    document.write("<li>" + answer + "</li>")
  }
}
