var mysql   = require('mysql');
var db  = require('./db_connection.js');

/* DATABASE CONFIGURATION */
var connection = mysql.createConnection(db.config);

exports.getAll = function(callback) {
    var query = 'SELECT * FROM address;';

    connection.query(query, function(err, result) {
        callback(err, result);
    });
};

exports.delete = function(address_id, callback){
    var query = 'delete from address where address_id = ' + address_id;

    connection.query(query, function(err, result){
        callback(err, result);
    });
};

exports.edit = function(addressObj, callback){
    var id = addressObj.address_id;
    var street = addressObj.street;
    var zip = addressObj.zip_code;
    var query= "update address set street = '" + street + "', zip code = " + zip + " where address_id = " + id + ";";
    console.log(query);
    connection.query(query, function(err, result){
        callback(err, result);
    })
}