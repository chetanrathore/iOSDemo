const dbCon = require('./../connection');
const _ = require('lodash');
var Promise = require("bluebird");

module.exports = {
    getAllCategory: getAllCategory,
    createCategory: createCategory,
    updateCategory: updateCategory,
    deleteCategory: deleteCategory,
    getCategoryById: getCategoryById,
};

function getAllCategory(){
    var sql = "select * from Category order by categoryId";
    return new Promise(function (resolve, reject) {
        dbCon.executeSql(sql, function(err, result) {
            return (err ? reject(err) : resolve(result));
        });
    });
}

function createCategory(category) {
    category = _.pick(category,['categoryName', 'description', 'categoryImage']);
    var sql = "insert into Category set ?";
    return new Promise(function (resolve, reject) {
        dbCon.executeInsert(sql, category, function (err, result) {
            if (err) {
                reject(err);
            }else{
                resolve(result);
            }
        });
    });
}

function updateCategory(category) {
    category = _.pick(category, ['categoryId', 'categoryName', 'description']);
    let sql = "update Category set ? where categoryId = ?";
    return new Promise(function (resolve, reject) {
        dbCon.executeUpdate(sql, category, category.categoryId, function (err, result) {
            if (err) {
                reject(err);
            }else{
                resolve(result);
            }
        });
    });
}

function deleteCategory(id) {
    let sql = "delete from Category where categoryId = " + id;
    return new Promise(function (resolve, reject) {
        dbCon.executeSql(sql, function(err, result){
            if (err) {
                reject(err);
            }else{
                resolve(result);
            }
        });
    });
}

function getCategoryById(id) {
    let sql = "select categoryId, categoryName, description from Category where categoryId = " + id;
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

function getCategoryPageNo(page) {
    let sql = "select categoryId, categoryName, description from Category where categoryId = " + id;
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