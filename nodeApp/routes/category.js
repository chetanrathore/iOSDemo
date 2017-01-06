const express = require('express');
const router = express.Router();
const categoryBLL = require('./../model/categorybll');

router.get('/category',function (req, res, next) {
    categoryBLL.getAll(function (err, result) {
       if (err) {
           return next(err);
       } else {
           res.send(result);
       }
    });
});

router.post('/category', function (req, res, next) {
    categoryBLL.create(req.body, function (err, result) {
       if (err) {
           return next(err);
       } else {
           res.send(result);
       }
    });
});

router.put('/category', function (req, res, next) {
   categoryBLL.update(req.body, function (err, result) {
        if (err) {
            return next(err);
        }else{
           res.send(result);
       }
   });
});

router.delete('/category/:id', function (req, res, next) {
    categoryBLL.delete(req.params.id, function (err, result) {
        if (err) {
            return next(err);
        }else {
            res.send(result);
        }
    });
});

router.get('/category/:id', function (req, res, next) {
    categoryBLL.getById(req.params.id, function (err, result) {
       if (err) {
           return next(err);
       }else{
           res.send(result);
       }
    });
});

module.exports = router;