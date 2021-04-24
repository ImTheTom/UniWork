//--Functions for the search functionality across the front page, results and the park pages of the website--//

//basic check function of the fields to make sure at least one has some sort of value in it
//if not it return false and displays an alert window to the user telling them that any one
//of the fields needs a value before they can search
function check(){
  var name = mainForm.name.value;
  var suburb = mainForm.suburb.value;
  var rating = mainForm.rating.value;
  var longitude = mainForm.longitude.value;

  if(name==""){
    if(suburb==""){
      if(rating==""){
        if(longitude==""){
          window.alert("Please enter a value to any one of the fields before trying to search.")
          return false;
        }
        return true;
      }
      return true;
    }
    return true;
  }
  return true;
}
