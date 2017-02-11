const express = require('express');
const router = express.Router();
const boom = require("boom");
const categoryBLL = require('./../model/productbll');
var constants = require('./../constant');
var ERROR = constants.ERRORS;
var MESSAGE = constants.MESSAGES;
var multer = require("multer");
const uuidV4 = require('uuid/v4');
var fileName = "";

var storage = multer.diskStorage({
    destination: function (req, file, callback) {
        // console.log("Inside destination" + file.originalname);
        callback(null, './public/product/');
    },
    filename: function (req, file, callback) {
        // console.log("Inside filename" + file.originalname);
        fileName = uuidV4() + file.originalname;
        callback(null, fileName);
    }
});

var upload = multer({storage: storage}).any();

router.get('/product',function (req, res, next) {
    categoryBLL.getAllProducts().then(function(result) {
        res.send(result);
    })
        .catch(function (err) {
            res.send(err);
        })
});

router.post('/product', upload, function (req, res, next) {
    req.body.productImage = fileName;
    categoryBLL.createProduct(req.body)
        .then(function(result) {
            res.status(200).json({ message: MESSAGE.INSERTED});
        })
        .catch(function (err) {
            res.status(404).json({ message: ERROR.INSERT_FAIL});
        })
});

router.get('/product/:id', function (req, res, next) {
    categoryBLL.getProductById(req.params.id).then(function(result) {
        res.send(result);
    })
        .catch(function (err) {
            res.send(err);
        })
});

router.get('/productbycategory/:id', function (req, res, next) {
    categoryBLL.getProductByCategory(req.params.id).then(function(result) {
        res.send(result);
    })
        .catch(function (err) {
            res.send(err);
        })
});

module.exports = router;