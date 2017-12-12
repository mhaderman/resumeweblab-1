var mysql   = require('mysql');
var mysql   = require('mysql');
var db  = require('./db_connection.js');

/* DATABASE CONFIGURATION */
var connection = mysql.createConnection(db.config);

exports.getAll = function(callback){
    var query = 'select * from account;';

    connection.query(query, function(err, result){
        callback(err, result);
    });
};

// Delete on cascade?
exports.delete = function(account_id, callback){
    var query = 'delete from account where account_id = ' + account_id;

    connection.query(query, function(err, result){
        callback(err, result);
    });
};

exports.getSchools = function(callback){
    var query = "select school_name, school_id from school";
    console.log(query);
    connection.query(query, function(err, result){
        callback(err, result);
    });
};


exports.getCompanies = function(callback){
    var query = "select company_name, company_id from company;";
    connection.query(query, function(err, result){
        callback(err, result);
    });
};


exports.getSkills = function(callback){
    var query = "select skill_name, skill_id from skill;";
    connection.query(query, function(err, result){
        callback(err, result);
    });
};

exports.addAcc = function(accountObj, callback){
    var query = "insert into account (email, first_name, last_name) values "+
        "('" + accountObj.email + "', '" + accountObj.first + "', '" + accountObj.last + "');" ;
    console.log("query: " + query);
    connection.query(query, function(err, result) {
        callback(err, result);
    });
};
/*
exports.addAccSchool
exports.addAccCompany
exports.addAccSkills
 */

exports.addAccSchool = function(accountObj, callback){
    var query = "insert into account_school (account_id, school_id, start_date, end_date, gpa) values ";
    if (accountObj.school_id instanceof Array){
        for (var i = 0; i < accountObj.school_id.length; i++) {
            query += "(" + accountObj.account_id + ", " + accountObj.school_id[i] + ", '2013-08-24 0:00', '2017-05-15 12:00', 3.5)";
            if (i < (accountObj.skill_id.length - 1)){
                console.log("i: " + i);
                query += " , ";
            }
        }
    }else{
        query += "(" + accountObj.account_id + ", " + accountObj.school_id + ", '2013-08-24 0:00', '2017-05-15 12:00', 3.5)";
    }
    console.log("query: " + query);
    connection.query(query, function(err, res){
        callback(err, res);
    });
};

exports.addAccCompany = function(accountObj, callback){
    var query = "insert into account_company (account_id, company_id) values ";

    if(accountObj.company_id instanceof Array ){
        for (var i = 0; i < accountObj.company_id.length; i++){
            query += "(" + accountObj.account_id + ", " + accountObj.company_id[i] + ")";
            if((i + 1) !== accountObj.company_id.length){
                query += " , ";
            }
        }
    }else{
        query += "(" + accountObj.account_id + ", " + accountObj.company_id + ");";
    }
    console.log("query: " + query);
    connection.query(query, function(err, res){
        callback(err, res);
    });
};

exports.addAccSkill = function(accountObj, callback){
    var query = "insert into account_skill (account_id, skill_id) values ";

    if(accountObj.skill_id instanceof Array ){
        for (var i = 0; i < accountObj.skill_id.length; i++){
            query += "(" + accountObj.account_id + ", " + accountObj.skill_id[i] + ")";
            if((i + 1) !== accountObj.skill_id.length){
                query += " , ";
            }
        }
    }else{
        query += "(" + accountObj.account_id + ", " + accountObj.skill_id + ");";
    }
    console.log("query: " + query);
    connection.query(query, function(err, res){
        callback(err, res);
    });
};




exports.edit = function(accountObj, callback){
    var last = accountObj.last_name;
    var id = accountObj.account_id;
    var email = accountObj.email;
    var first = accountObj.first_name;
    var query = "update account set first_name = '" + first + "', last_name =  '" + last + "', email = '"
        + email + "' where account_id = " + id;
    connection.query(query, function(err, result){
        callback(err, result);
    });
    //let { account_id, email, first_name, last_name } = accountObj;
};