const con = require("./../connection");
const _ = require("lodash");
const Promise = require('bluebird');

module.exports = {
    getAllProduct: getAllProduct,
};

function getAllProduct() {
    let sql = "select * from Product";
    return new Promise(function (resolve, reject) {
        con.executeSql(function (err, result) {
            if (err){
                reject(err);
            }else{
                resolve(result);
            }
        });
    });
}

function createProduct(product) {

}