var mysql   = require('mysql');
var db  = require('./db_connection.js');

/* DATABASE CONFIGURATION */
var connection = mysql.createConnection(db.config);

exports.getAll = function(callback) {
    var query = 'SELECT * FROM school;';

    connection.query(query, function(err, result) {
        callback(err, result);
    });
};

exports.delete = function(school_id, callback){
    var query = 'delete from school where school_id = ' + school_id;

    connection.query(query, function(err, result){
        callback(err, result);
    });
};

exports.edit = function(addressObj, callback){
    var id = addressObj.school_id;
    var school = addressObj.school_name;
    var address_id = addressObj.address_id;
    var query= "update school set school_name = '" + school + "', address_id = " + address_id + " where school_id = " + id +";";
    connection.query(query, function(err, result){
        callback(err, result);
    })
}