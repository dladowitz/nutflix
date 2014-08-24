
//variables and conditionals
var age = 19
if(age >= 18){
  document.write("<strong>You can vote</strong>")
}

var name = "david"
if(name == "david"){
  document.write("</br>You win!")
}

if(name == "david" && age > 18){
  document.write("</br> You did it</br>")
}

if(name == "dusty"){
  document.write("Hello Dusty")
} else if(name == "Aiko") {
  document.write("Hello Aiko")
} else {
  document.write("<span style='color:red'>who are you?</span>")
}

var score = 85;
var grade;

if(score >= 90){
  grade = "A";
} else if(score >= 80) {
  grade = "B";
} else if(score >= 70) {
  grade = "C";
} else if(score >= 60) {
  grade = "D";
} else {
  grade = "F";
}

document.write("<p>Youre grade is: " + grade + "</p>")


//dialog boxes
//var hungriest = prompt("Who is the hungriest cat today?")
var hungriest = "Dusty";
var catColor;

switch(hungriest){
  case "Aiko":
    catColor = "Black";
    break;
  case "Dusty":
    catColor = "Grey";
    break;
  case "Teresa":
    catColor = "Yellow";
    break;
  default:
    catColor = "Unknown";
    break;
}

document.write("<p style=color:" + catColor + ">")
document.write("The color of the hungriest cat is: " + catColor)
document.write("</p>")

//var confirmationResult = confirm("Are you a cat today?");
//document.write(confirmationResult)

document.write("#################### </br>");

//loops

var age = 0;

document.write("<ul>");
while(age < 10){
  document.write("<li>This year I am " + age + "</li>");
  age++;
}
document.write("</ul>");

document.write("####################");

document.write("<ul>");
do {
  document.write("<li>Current Age is: " + age + "</li>");
  age ++;
}while(age < 20);
document.write("</ul>");

document.write("####################");

for(age = 30; age < 40; age++){
  document.write("<li>Age now is: " + age + "</li>");
}
