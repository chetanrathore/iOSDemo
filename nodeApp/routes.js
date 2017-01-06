var express = require('express');
var router = express.Router();
var categoryBLL = require('./categorybll.js');

router.get('/category',function (req, res, next) {
    console.log('f-------------');
    categoryBLL.getAll(function (err, result) {
       if (err) {
           return next(err);
       } else {
           res.send(result);
       }
    });
});

module.exports = router;