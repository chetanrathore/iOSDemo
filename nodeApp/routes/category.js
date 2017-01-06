const express = require('express');
const router = express.Router();
const boom = require("boom");

const categoryBLL = require('./../model/categorybll');

var constants = require('./../constant');
var ERROR = constants.ERRORS;
var MESSAGE = constants.MESSAGES;

router.get('/category',function (req, res, next) {
    categoryBLL.getAllCategory().then(function(result) {
        res.send(result);
    })
        .error(function (err) {

    })
});

router.post('/category', function (req, res, next) {
    categoryBLL.createCategory(req.body).then(function(result) {
        res.send({ message: MESSAGE.CATEGORY_INSERTED });
    })
        .error(function (err) {
            res.send({ message: ERROR.CATEGORY_INSERT_FAIL });
    })
});

router.put('/category', function (req, res, next) {
    categoryBLL.updateCategory(req.body).then(function(result) {
        res.send(result);
    })
        .error(function (err) {
    })
});

router.delete('/category/:id', function (req, res, next) {
    categoryBLL.deleteCategory(req.params.id).then(function(result) {
        res.send(result);
    })
        .error(function (err) {
    })
});

router.get('/category/:id', function (req, res, next) {
   categoryBLL.getCategoryById(req.params.id).then(function(result) {
        res.send(result);
   })
       .error(function (err) {
   })
});

/*
router.get('/category',function (req, res, next) {
    categoryBLL.getAllCategory(function (err, result) {
       if (err) {
           return next(err);
       } else {
           res.send(result);
       }
    });
});

router.post('/category', function (req, res, next) {
    categoryBLL.createCategory(req.body, function (err, result) {
       if (err) {
           return next(err);
       } else {
           res.send(result);
       }
    });
});

router.put('/category', function (req, res, next) {
   categoryBLL.updateCategory(req.body, function (err, result) {
        if (err) {
            return next(err);
        }else{
           res.send(result);
       }
   });
});

router.delete('/category/:id', function (req, res, next) {
    categoryBLL.deleteCategory(req.params.id, function (err, result) {
        if (err) {
            return next(err);
        }else {
            res.send(result);
        }
    });
});

router.get('/category/:id', function (req, res, next) {
    categoryBLL.getCategoryById(req.params.id, function (err, result) {
       if (err) {
           return next(err);
       }else{
           res.send(result);
       }
    });
});
*/
module.exports = router;