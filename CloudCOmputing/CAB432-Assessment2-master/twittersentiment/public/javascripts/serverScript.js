module.exports = {
    getCurrentAustraliaTime: function() {
        let date = new Date();
        date.setHours(date.getHours() + 10);
        let year = date.getUTCFullYear();
        let month = date.getUTCMonth() + 1;
        let day = date.getUTCDate();
        let hour = date.getUTCHours();
        let minute = date.getUTCMinutes();
        let current_time =
            year + "-" + month + "-" + day + "T" + hour + ":" + minute + ":00";
        return current_time;
    },

    parseTweetDate: function(tweetDateString) {
        let splitString = tweetDateString.split(" ");
        let month = splitString[1];
        let day = splitString[2];
        let time = splitString[3];
        let year = splitString[5];
        return day + " " + month + " " + year + " " + time + " GMT";
    },

    timeSinceDate: function(date, formatted) {
        let timeElapsed;
        let now = Date.now();
        let then;
        if (formatted) then = Date.parse(date);
        else then = date;
        let difference = now - then;
        let weeks = Math.floor(difference / 604800000);
        let days = Math.floor(difference / 86400000);
        let hours = Math.floor(difference / 3600000);
        let minutes = Math.floor(difference / 60000);
        let seconds = Math.floor(difference / 1000);

        if (weeks > 0) {
            timeElapsed = weeks + " weeks ago";
        } else if (days > 0) {
            timeElapsed = days + " days ago";
        } else if (hours > 0) {
            timeElapsed = hours + " hours ago";
        } else if (minutes > 0) {
            timeElapsed = minutes + " minutes ago";
        } else if (seconds > 0) {
            timeElapsed = seconds + " seconds ago";
        } else {
            timeElapsed = "under a second ago";
        }
        return timeElapsed;
    },

    // returns 1 if date1 is most recent, returns 2 if date 2 is most recent
    compareDates: function(_date1, _date2) {
        let date1 = Date.parse(_date1);
        let date2 = Date.parse(_date2);
        if (date1 > date2) return 1;
        else return 2;
    },
};