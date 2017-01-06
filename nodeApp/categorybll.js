const dbCon = require('./connection.js');

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
