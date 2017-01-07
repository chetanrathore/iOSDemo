// const mysql = require('mysql');
//
// var Promise = require("bluebird");
// Promise.promisifyAll(require("mysql/lib/Connection").prototype);
// Promise.promisifyAll(require("mysql/lib/Pool").prototype);

var db = require(' promise-mysql')();


db.configure({
    host: 'localhost',
    password: 'root',
    user: 'root',
    port: '8889',
    database: 'ShoppingDB',
    multipleStatements: true,
});


function Connection() {
    this.pool = null;
    this.init = function () {
        this.pool = mysql.createPool({
            connectionLimit: 10,
            host: 'localhost',
            password: 'root',
            user: 'root',
            port: '8889',
            database: 'ShoppingDB',
            multipleStatements: true
        });
    };

    // this.init  = function(){
    //     return new Promise(function (resolve, reject) {
    //         let conn = mysql.createPool({
    //             connectionLimit: 10,
    //             host: 'localhost',
    //             password: 'root',
    //             user: 'root',
    //             port: '88888',
    //             database: 'ShoppingDB',
    //             multipleStatements: true
    //         });
    //         console.log(conn);
    //         if (conn != null) {
    //             console.log("dfgdfg");
    //             resolve(conn);
    //         }else{
    //             console.log("fail");
    //             reject("fail to connect with mysql");
    //         }
    //     });
    // }

    // this.connect = function(){
    //     return new Promise(function (resolve, reject) {
    //         var mysqlConnection = this.pool.getConnection();
    //         mysqlConnection.on('ready', function () {
    //             console.log("Connect");
    //             resolve(mysqlConnection);
    //         });
    //         mysqlConnection.on('error', function (err) {
    //             console.log("Fail");
    //             reject(err);
    //         });
    //     });
    // };


    db.query('UPDATE foo SET key = ?', ['value']).then(function () {
        return db.query('SELECT * FROM foo');
    }).spread(function (rows) {
        console.log('Loook at all the foo', rows);
    });


    this.executeSql = function (sql) {
        console.log(sql);
        return new Promise(function (resolve, reject) {
            this.pool.getConnection(function (err, connection) {
                console.log(err);
                console.log(connection);
                if (err) {
                    reject(err);
                }else{
                    connection.query(sql, function (err, result) {
                        if(err) {
                            reject(err);
                        }else{
                            resolve(result);
                        }
                    });
                }
            });
        });
    };



    // this.executeSql=function (sql,callback) {
    //     this.pool.getConnection(function (err,connection) {
    //         if(err){
    //             console.log(err);
    //             err.status=500;
    //             callback(err,null);
    //         }else
    //         {
    //             connection.query(sql,function (err,result) {
    //                 if(err){
    //                     console.log(err);
    //                     err.status=500;
    //                     callback(err,null);
    //                 } else{
    //                     connection.release();
    //                     callback(null,result);
    //                 }
    //             });
    //         }
    //     });
    //
    // };

    this.executeInsert=function (sql,obj,callback) {
        this.pool.getConnection(function (err,connection) {
            if(err){
                console.log(err);
                err.status=500;
                callback(err,null);
            }else
            {
                connection.query(sql,obj,function (err,result) {
                    if(err){
                        console.log(err);
                        err.status=500;
                        callback(err,null);
                    } else{
                        connection.release();
                        callback(null,result);
                    }
                });
            }
        });
    };

    this.executeUpdate=function (sql,obj,id,callback) {
        this.pool.getConnection(function (err,connection) {
            if(err){
                console.log(err);
                err.status=500;
                callback(err,null);
            }else
            {
                connection.query(sql,[obj,id],function (err,result) {
                    if(err){
                        console.log(err);
                        err.status=500;
                        callback(err,null);
                    } else{
                        connection.release();
                        callback(null,result);
                    }
                });
            }
        });
    };
}

module.exports = new Connection();
