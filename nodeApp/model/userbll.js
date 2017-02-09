/**
 * Created by LaNet on 1/12/17.
 */
const dbCon = require('./../connection');
const _ = require('lodash');
var Promise = require("bluebird");
var passwordHash = require('password-hash');

module.exports = {
    userRegister: userRegister,
    userLogin: userLogin,
}

// function userRegister(user) {
//     return new Promise(function (resolve,reject) {
//         if (isEmailAlreadyExist(user.emailId)){
//             console.log("inside already exists");
//             reject(false);
//         }else {
//             user.password = passwordHash.generate(user.password);
//             user.createdOn = new Date();
//             user = _.pick(user, ['fullName', 'emailId', 'password', 'createdOn']);
//             var sql = "insert into User set ?";
//             dbCon.executeInsert(sql, user, function (err, result) {
//                if (err) {
//                    reject(err);
//                }else{
//                    resolve(result);
//                }
//             });
//         }
//     });
// }

// function isEmailAlreadyExist(email) {
//     var sql = "select * from User where emailId = '" + email + "'";
//     dbCon.executeSql(sql, function (err, result) {
//         if (err) {
//             return false;
//         } else {
//             if (result.length != 0) {
//                 return true;
//             } else {
//                 return false;
//             }
//         }
//     });
// }

function userRegister(user) {
    return new Promise(function (resolve,reject) {
        isEmailAlreadyExist(user.emailId).then(function (isexist) {
                if (isexist) {
                    reject(false);
                }else{
                    user.password = passwordHash.generate(user.password);
                    user.createdOn = new Date();
                    user = _.pick(user, ['fullName', 'emailId', 'password', 'createdOn']);
                    var sql = "insert into User set ?";
                    dbCon.executeInsert(sql, user, function (err, result) {
                        if (err) {
                            reject(err);
                        }else{
                            resolve(result);
                        }
                    });
                }
        })
            .catch(function (isexist) {
                    reject(false);
            });
    });
}

function isEmailAlreadyExist(email) {
    var sql = "select userId from User where emailId = '" + email + "'";
    return new Promise(function (resolve, reject) {
        dbCon.executeSql(sql, function (err, result) {
            if (err) {
                reject(err);
            } else {
                if (result.length != 0) {
                    resolve(true);
                } else {
                    resolve(false);
                }
            }
        });
    });
}

function userLogin(user) {
    var sql = "select userId, fullName, emailId, password from User where emailId = '"+ user.emailId +"'";
    return new Promise(function (resolve, reject) {
       dbCon.executeSql(sql, function (err, result) {
            if (err) {
                reject(err);
            }else{
                if(result.length != 0) {
                    if (passwordHash.verify(user.password, result[0]["password"])) {
                        resolve(result);
                    }else {
                        reject(false);
                    }
                }
                reject(true);
            }
       });
    });
}