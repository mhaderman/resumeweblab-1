var mysql   = require('mysql');
var db  = require('./db_connection.js');

/* DATABASE CONFIGURATION */
var connection = mysql.createConnection(db.config);

exports.getAll = function(callback) {
    var query = 'SELECT * FROM skill;';

    connection.query(query, function(err, result) {
        callback(err, result);
    });
};

exports.delete = function(skill_id, callback){
    var query = 'delete from skill where skill_id = ' + skill_id;

    connection.query(query, function(err, result){
        callback(err, result);
    });
};

exports.edit = function(addressObj, callback) {
    var id = addressObj.skill_id;
    var skill = addressObj.skill_name;
    var description = addressObj.description;
    var query = "update skill set skill_name = " + skill + ", description = " + description + "where skill_id = " + id;
    connection.query(query, function (err, result) {
        callback(err, result);
    })
}