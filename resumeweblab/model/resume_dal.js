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
    connection.query(query, function(err, result){
        console.log("account school dal:" + result);
        callback(err, result);
    });
};

exports.accountCompany = function(account_id, callback){
    var query = "select school_name from school s join account_school a on a.school_id " +
        "= s.school_id where account_id = " + account_id;
    connection.query(query, function(err, result){
        console.log("account company dal:" + result);
        callback(err, result);
    });
};

exports.accountSkill = function(account_id, callback){
    var query =  "select skill_name from skill s join account_skill a on a.skill_id = s.skill_id " +
        "where account_id = " + account_id;
    connection.query(query, function(err, result){
        callback(err, result);
    });
};
// Inserts
exports.insert = function(resumeObj, callback){
    //console.log("resume obj: " + resumeObj);
    var query = "insert into resume (account_id, resume_name) values " +
        "(" + resumeObj.account_id + ", '" + resumeObj.resume_name + "');";
    connection.query(query, function(err, res){
        callback(err, res);
    });
};

exports.insertResumeCompany = function(resumeObj, callback){
    var query = "insert into resume_company (resume_id, company_id, date_shared, was_hired) values ";
    if(resumeObj.company_id instanceof Array) {
        for (var i = 0; i < resumeObj.company_id.length; i++) {          //hard coded date_shared, was_hired values
            query += "(" + resumeObj.resume_id + ", " + resumeObj.company_id[i] + ", '" + "2017-01-01 12:00" + "', '" + "true" + "')";
            if ((i + 1) !== resumeObj.company_id.length) {
                query += " , ";
            }
        }
    }else{
        query += "(" + resumeObj.resume_id + ", " + resumeObj.company_id + ", '" + "2017-01-01 12:00" + "', '" + "true" + "')";
    }

    console.log("query: " + query);
    connection.query(query, function(err, res){
        callback(err, res);
    });
};


exports.insertResumeSkill = function(resumeObj, callback){


    var query = "insert into resume_skill (resume_id, skill_id) values ";
    //make these accept the case and still form a query where resumeObj.skill_id is
    //either an array of ints or a single int
    if(resumeObj.skill_id instanceof Array ){
        for (var i = 0; i < resumeObj.skill_id.length; i++){
            query += "(" + resumeObj.resume_id + ", " + resumeObj.skill_id[i] + ")";
            if((i + 1) !== resumeObj.skill_id.length){
                query += " , ";
            }
        }
    }else{
        query += "(" + resumeObj.resume_id + ", " + resumeObj.skill_id + ");";
    }
    console.log("query: " + query);
    connection.query(query, function(err, res){
        callback(err, res);
    });
};


exports.insertResumeSchool = function(resumeObj, callback){
    var query = "insert into resume_school (resume_id, school_id) values ";
    console.log(resumeObj.school_id);
    if(resumeObj.school_id instanceof Array) {
        for (var i = 0; i < resumeObj.school_id.length; i++) {
            query += "(" + resumeObj.resume_id + ", " + resumeObj.school_id[i] + ")";
            if ((i + 1) !== resumeObj.school_id.length) {
                query += " , ";
            }
        }
    }else{
        query += "(" + resumeObj.resume_id + ", " + resumeObj.school_id + ");";
    }
    console.log("query: " + query);
    connection.query(query, function(err, res){
        callback(err, res);
    });
};