var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('index', {
        title: 'TwitterSentiment'
    });
});

// This endpoint isn't use in main functionality
router.get('/test', function(req, res, next) {
    let start = Date.now();
    for (let i = 0; i <= 1000000000; i++) {
        let dummy = Math.log(i + 1);
    }

    let timing = Date.now() - start;
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello World\n ' + timing + 'ms \n');
});

module.exports = router;