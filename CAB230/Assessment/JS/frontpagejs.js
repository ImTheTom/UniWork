function myLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showLocation);
  }else{
    alert("Sorry, browser does not support geolocation!");
  }
}

function showLocation(position) {
  var latitude = position.coords.latitude;
  document.getElementById("latitude").value = latitude;
  var longitude = position.coords.longitude;
  document.getElementById("longitude").value = longitude;
}
