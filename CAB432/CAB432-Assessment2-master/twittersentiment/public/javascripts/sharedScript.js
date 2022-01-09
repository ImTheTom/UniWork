// html related JS
function seachForHashtag(tag) {
    let searchterm = document.getElementById(tag).value
    if (searchterm.length == 0) return;
    window.location.assign("/search/" + searchterm);
};

function goToSearch() {
    window.location.assign("/");
};

/*function timeSinceDate(date) {
    console.log("called");
    let timeElapsed;
    let now = Date.now();
    let then = Date.parse(date);
    let difference = now - then;
    console.log(difference);

    return timeElapsed;
};*/