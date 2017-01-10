const express = require('express');
const router = express.Router();
const boom = require("boom");
const categoryBLL = require('./../model/categorybll');
var constants = require('./../constant');
var ERROR = constants.ERRORS;
var MESSAGE = constants.MESSAGES;
var multer = require("multer");
const uuidV4 = require('uuid/v4')
var fileName = "";
var storage = multer.diskStorage({
    destination: function (req, file, callback) {
       // console.log("Inside destination" + file.originalname);
        callback(null, './public/');
    },
    filename: function (req, file, callback) {
        // console.log("Inside filename" + file.originalname);
        fileName = uuidV4() + file.originalname;
        callback(null, fileName);
    }
});
var upload = multer({storage: storage}).any();

router.get('/category',function (req, res, next) {
    categoryBLL.getAllCategory().then(function(result) {
        res.send(result);
    })
        .catch(function (err) {
        res.send(err);
    })
});

router.post('/category', upload, function (req, res, next) {
    console.log("inside post" + fileName);
    req.body.categoryImage = fileName;
    categoryBLL.createCategory(req.body)
        .then(function(result) {
            res.status(200).json({ message: MESSAGE.CATEGORY_INSERTED});
    })
        .catch(function (err) {
            res.status(404).json({ message: ERROR.CATEGORY_INSERT_FAIL});
    })
});

router.put('/category', function (req, res, next) {
    categoryBLL.updateCategory(req.body).then(function(result) {
        res.status(200).json({ message: MESSAGE.CATEGORY_UPDATED});
    })
        .catch(function (err) {
            res.status(404).json({ message: ERROR.CATEGORY_UPDATE_FAIL});
    })
});

router.delete('/category/:id', function (req, res, next) {
    categoryBLL.deleteCategory(req.params.id).then(function(result) {
        res.status(200).json({ message: MESSAGE.CATEGORY_DELETED});
    })
        .catch(function (err) {
            res.status(404).json({ message: ERROR.CATEGORY_DELETE_FAIL});
    })
});

router.get('/category/:id', function (req, res, next) {
   categoryBLL.getCategoryById(req.params.id).then(function(result) {
           res.send(result);
   })
       .catch(function (err) {
           res.send(err);
   })
});

module.exports = router;