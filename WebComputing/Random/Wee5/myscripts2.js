function date(){
  document.write(Date());
}

function createbox(){
  document.getElementById("mouseover").style.color = "black";
  document.getElementById("box").style.color = "white";
  document.getElementById("box").style.background = "black";

}

function removebox(){
  document.getElementById("mouseover").style.color = "black";
  document.getElementById("box").style.color = "white";
  document.getElementById("box").style.background = "white";
}


function get3(table){
  var Row = document.getElementById("table");
  var Cells = Row.getElementsByTagName("td");
  for(var i =0; i<18;i=i+3){
    if(Cells[i].innerText<3){
      Cells[i].style.color = "White";
      Cells[i+1].style.color = "White";
      Cells[i+2].style.color = "White";
    }
  }
}

function getLocation() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(showPosition, showError);
	} else {
		document.getElementById("status").innerHTML="Geolocation is not supported by this browser.";
	}
}

Number.prototype.toRadians = function() {
   return this * Math.PI / 180;
}

function showPosition(position) {
	document.getElementById("status").innerHTML = "Latitude: " + position.coords.latitude + ", Longitude: " + position.coords.longitude;

	// display on a map
	var latlon = position.coords.latitude + "," + position.coords.longitude;
	var img_url = "http://maps.googleapis.com/maps/api/staticmap?center="+latlon+"&zoom=14&size=400x300&sensor=false";
	document.getElementById("mapholder").innerHTML = "<img src='"+img_url+"'>";

  var aLat = position.coords.latitude;
  var aLong = position.coords.longitude;
  var bLat =  28.418611;
  var bLong = -81.581111;

  var R = 6371e3; // metres
  var f = aLat.toRadians();
  var g = bLat.toRadians();
  var u = (bLat-aLat).toRadians();
  var i = (bLong-aLong).toRadians();

  var a = Math.sin(u/2) * Math.sin(u/2) +
          Math.cos(f) * Math.cos(g) *
          Math.sin(i/2) * Math.sin(i/2);
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

  var d = R * c;
document.getElementById("demo").innerHTML = "Your distance to Disney World is " + d + " metres";
}

function showError(error) {
	var msg = "";
	switch(error.code) {
		case error.PERMISSION_DENIED:
			msg = "User denied the request for Geolocation."
			break;
		case error.POSITION_UNAVAILABLE:
			msg = "Location information is unavailable."
			break;
		case error.TIMEOUT:
			msg = "The request to get user location timed out."
			break;
		case error.UNKNOWN_ERROR:
			msg = "An unknown error occurred."
			break;
	}

}

function park(name, suburb) {
    this.Name = name;
    this.Suburb = suburb;
}

var park1 = new park("7TH BRIGADE PARK", "CHERMSIDE");
var park2 = new park("BENEKE STREET PARK", "CHERMSIDE");
var park3 = new park("DOCK STREET PARK", "SOUTH BRISBANE");

function same(){
  if (park1.Suburb==park2.Suburb){
    document.getElementById("parksss").innerHTML = "7th Brigade Park and Beneke Street Park are in the same suburb. ";
  }else{
    document.getElementById("parksss").innerHTML ="7th Brigade Park and Beneke Street Park are not in the same suburb. "
  }
  if (park2.Suburb==park3.Suburb){
    document.getElementById("parksss").innerHTML = document.getElementById("parksss").innerHTML+ "Dock street park and Beneke Street Park are in the same suburb. ";
  }else{
    document.getElementById("parksss").innerHTML = document.getElementById("parksss").innerHTML+ "Dock street park and Beneke Street Park are not in the same suburb. ";
  }
  if (park1.Suburb==park3.Suburb){
    document.getElementById("parksss").innerHTML = document.getElementById("parksss").innerHTML+ "Dock street park and 7th Brigade Park are in the same suburb. ";
  }else{
    document.getElementById("parksss").innerHTML = document.getElementById("parksss").innerHTML+ "Dock street park and 7th Brigade Park are not in the same suburb. ";
  }
}
