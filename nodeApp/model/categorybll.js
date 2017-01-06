const dbCon = require('./../connection.js');
const _ = require('lodash');

exports.getAll = function(callback){
    var sql = "select * from Category order by categoryId";
    dbCon.executeSql(sql, function(err, result) {
       if (err) {
           callback(err, null);
       }  else {
           callback(null, result);
       }
    });
}

exports.create = function(category, callback) {
    category = _.pick(category,['categoryName', 'description']);
    var sql = "insert into Category set ?";
    dbCon.executeInsert(sql, category, function (err, result) {
        if (err) {
            callback(err, null);
        }else{
            callback(null, result);
        }
    });
}

exports.update = function (category, callback) {
    category = _.pick(category, ['categoryId', 'categoryName', 'description']);
    let sql = "update Category set ? where categoryId = ?";
    dbCon.executeUpdate(sql, category, category.categoryId, function (err, result) {
        if (err) {
            callback(err, null);
        }else {
            callback(null, result);
        }
    });
}

exports.delete = function (id, callback) {
    let sql = "delete from Category where categoryId = " + id;
    dbCon.executeSql(sql, function(err, result){
        if (err) {
            callback(err, null);
        }else{
            callback(null, result);
        }
    });
}

exports.getById = function (id, callback) {
    let sql = "select categoryId, categoryName, description from Category where categoryId = " + id;
    dbCon.executeSql(sql, function (err, result) {
       if (err){
           callback(err, null);
       }else{
           callback(null, result);
       }
    });
}