var express = require('express');
var router = express.Router();
var resume_dal = require('../model/resume_dal');
var account_dal = require('../model/account_dal');
var insert = require('../model/Universal');


router.get('/add/selectUser', function(req, res){
    console.log("PAGE CALLED");
    account_dal.getAll(function(err, response) {
        console.log("email, first, last: " + response);
        res.render('resume/resumeUserSelect', {response: response});

    });

});

router.get('/add/selectUser/:id', function(req, res){
    var id = req.params.id;
    console.log('RESUME ADD PAGE');
    resume_dal.accountSchool(id, function(err, school){
        resume_dal.accountCompany(id, function(err2, company){
            resume_dal.accountSkill(id, function(err3, skill){
                // MY OBJECT Wrapped
                var result = {school: school,
                            company: company,
                            skill: skill,
                            id: id
                };
                //defined: [Object object]
                // und : UND
                console.log('result, school: ' + result.school);
                console.log('Result: ' + school + company + skill);
                // PASS OBJECT
                res.render('resume/resumeCreateForm', {response: result})
            });
        });
    });
});

router.post('/insert/:id', function(req, res){
    //Create an wrapper with resName, aID, cID, scID, sID req.body
    var id = req.params.id;
    var resume_name = req.body.resume_name;
    var company_id = req.body.company_id;
    var school_id = req.body.school_id;
    var skill_id = req.body.skill_id;
    var result = {account_id: id,
                resume_name: resume_name,
                company_id: company_id,
                school_id: school_id,
                skill_id: skill_id};

    console.log("resume_relevant_obj company" + obj.company_id);
    console.log("resume_relevant_obj school"+ obj.school_id);
    console.log("resume_relevant_obj skill" + obj.skill_id);
    resume_dal.insert(obj, function(err, result){
        if(err){
            console.log("insert threw err")
            res.send(err);
        }else{
            var resume_id = result.insertId;
            var totalInsertObj = {
                company_id: obj.company_id,
                school_id: obj.school_id,
                skill_id: obj.skill_id,
                resume_id: obj.resume_id
            };
            console.log(" Res_Insert SUCESS!");
            console.log(totalInsertObj);
            resume_dal.insertResumeSchool(totalInsertObj, function(err2, res2){
                if(err2){
                    console.log("school err");
                    res.send(err2);
                }else{
                    resume_dal.insertResumeCompany(totalInsertObj, function(err3, res3){
                        if(err3){
                            console.log("company err");
                            res.send(err3);
                        }else{
                            resume_dal.insertResumeSkill(totalInsertObj, function(err4, res4){
                                if(err4){
                                    console.log("skill err");
                                    res.send(err4);
                                }else{
                                    console.log("ALL INSERTS INSERTED");
                                    res.send("Booya ! :D");
                                }
                            })
                        }
                    })

                }
            })
        }
    })
});


module.exports = router;
//router.get('/change/:id')