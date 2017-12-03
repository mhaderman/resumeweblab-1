var mysql = require('mysql');
var db = require('./db_connection.js');

var connection = mysql.createConnection(db.config);

exports.getAll = function(callback){
    var query = 'SELECT * from account;';

    connection.query(query, function(err, result){
        callback(err, result);
    });
};

exports.join = function(callback){
    var query = 'select * from account left join account_company on account.account_id = account_company.account_id;';
    connection.query(query, function(err, result){
        callback(err, result);
    });
};

exports.delete = function(account_id, callback){
    var query = 'delete from account where account_id = ' + account_id;
    connection.query(query, function(err, result){
        callback(err, result);
    });
};

exports.edit = function(accountObj, callback){
    var email = accountObj.email;
    var id = accountObj.account_id;
    var query = "update account set email = '" + email + "', where account_id = " + id + ";";
    connection.query(query, function(err, result){
        callback(err, result);
    });
};