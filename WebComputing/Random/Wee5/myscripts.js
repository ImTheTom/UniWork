function echo(msg) {
window.alert("Echoing: " + msg);
}
function changeIt() {
var el = document.getElementById("welcome");
el.innerHTML = "Goodbye, world!";
el.style.backgroundColor = "#ffcccc";
}

//function changeIt() {
//  var listItems = document.getElementsByTagName("li");
//    for (var i = 0; i < listItems.length; i++) {
//      listItems[i].style.color = "#00ff00";
//    }
//}

function sortList(listId) {
var children = listId.childNodes;
// store the contents of all <li> elements in an array
var listItemsHTML = new Array();
for (var i = 0; i < children.length; i++) {
/* the list also contains some "text nodes" representing the whitespace
between the elements, so we only want to take the <li> elements */
if (children[i].nodeName === "LI") {
listItemsHTML.push(children[i].innerHTML);
}
}
// sort the array
listItemsHTML.sort();
// replace the contents of the list with it
listId.innerHTML = "";
for (var i = 0; i < listItemsHTML.length; i++) {
listId.innerHTML += "<li>" + listItemsHTML[i] + "</li>";
}
}
