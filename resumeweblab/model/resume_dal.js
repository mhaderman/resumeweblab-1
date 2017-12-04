var mysql = require('mysql');
var db = require('./db_connection.js');

var connection = mysql.createConnection(db.config);

exports.getAll = function(callback) {
    var query = 'select first_name, last_name, resume_name from account a left join resume r on r.account_id = a.account_id;';
    console.log(query);
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
    });
};

exports.accountSchool = function(account_id, callback){
    var query = "select school_name from school s join account_school a on a.school_id " +
        "= s.school_id where account_id = " + account_id;
    connection.query(query, function(err, school){
        console.log("account school dal:" + school);
        callback(err, school);
    });
};

exports.accountCompany = function(account_id, callback){
    var query = "select school_name from school s join account_school a on a.school_id " +
        "= s.school_id where account_id = " + account_id;
    connection.query(query, function(err, company){
        console.log("account company dal:" + company);
        callback(err, company);
    });
};

exports.accountSkill = function(account_id, callback){
    var query =  "select skill_name from skill s join account_skill a on a.skill_id = s.skill_id " +
        "where account_id = " + account_id;
    connection.query(query, function(err, skill){
        callback(err, skill);
    });
};