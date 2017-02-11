const dbCon = require('./../connection');
const _ = require('lodash');
var Promise = require("bluebird");

module.exports = {
    createProduct: createProduct,
    getProductByCategory: getProductByCategory,
    getAllProducts: getAllProducts,
    getProductById: getProductById,
};

function createProduct(product) {
    product.createdDate = new Date();
    product = _.pick(product,['productName', 'description', 'productImage', 'retailPrice', 'sellingPrice', 'categoryId', 'quantity', 'createdDate']);
    var sql = "insert into Product set ?";
    return new Promise(function (resolve, reject) {
        dbCon.executeInsert(sql, product, function (err, result) {
            if (err) {
                reject(err);
            }else{
                resolve(result);
            }
        });
    });
}

function getProductByCategory(id) {
    var sql = "select * from Product where categoryId = "+id;
    return new Promise(function (resolve, reject) {
        dbCon.executeSql(sql, function(err, result) {
            return (err ? reject(err) : resolve(result));
        });
    });
}

function getAllProducts(){
    var sql = "select * from Product order by productId";
    return new Promise(function (resolve, reject) {
        dbCon.executeSql(sql, function(err, result) {
            return (err ? reject(err) : resolve(result));
        });
    });
}

function getProductById(id) {
    let sql = "select * from Product where productId = " + id;
    return new Promise(function (resolve, reject) {
        dbCon.executeSql(sql, function (err, result) {
            if (err) {
                reject(err);
            } else {
                resolve(result);
            }
        });
    });
}