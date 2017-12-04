var express = require('express');
var router = express.Router();
var resume_dal = require('../model/resume_dal');
var account_dal = require('../model/account_dal');
var insert = require('../model/Universal');


router.get('/add/selectUser', function(req, res){
    console.log("PAGE CALLED");
    account_dal.getAll(function(err, response){
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
                console.log('result, school: ' + result.school);
                console.log('Result: ' + school + company + skill);
                // PASS OBJECT
                res.render('resume/resumeCreateForm', {response: result})
            });
        });
    });
});


module.exports = router;
//router.get('/change/:id')