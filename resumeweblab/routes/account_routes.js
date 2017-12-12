var express = require('express');
var router = express.Router();
var account_dal = require('../model/account_dal');
var insert = require('../model/universal');   //access with url: localhost3000:/account/insert

router.get('/all', function(req, res){
    account_dal.getAll(function(err, response) {
        //console.log(response);
        res.render('account/accountViewAll', {response : response});
    });
});


router.get('/insert', function(req, res) {
    //need to get all of the school names & ids, companies & ids, skills & ids
    /*
            account_dal.getSchool()
            account_dal.getCompanies(function(err2, Companies)
            account_dal.getSkills(function(err3, Skills)
     */
    account_dal.getSchools(function (err1, school) {
        if(err1){
            console.log("error1 thrown");
            res.send(err1);
        }else{
            account_dal.getCompanies(function(err2, company){
                if(err2){
                    console.log("error2 thrown");
                    res.send(err2);
                }else{
                    account_dal.getSkills(function(err3, skill){
                        if(err3){
                            console.log("error3 thrown");
                            res.send(err3);
                        }else{
                            var obj =   {school:school,    //wrapper obj
                                company: company,
                                skill: skill };
                            res.render('account/accountAdd', {response : obj});
                        }
                    })
                }
            })
        }
    })
})
router.post('/insert', function(req, res) {//gets called to add a new record.
    var accountObj =    {first: req.body.first_name,
        last: req.body.last_name,
        email: req.body.email,
        school_id: req.body.school_id,
        company_id: req.body.company_id,
        skill_id: req.body.skill_id};
    console.log(accountObj);
    if((accountObj.first || accountObj.last || accountObj.email || accountObj.school_id || accountObj.company_id || accountObj.skill_id) === null){
        res.send("not enough relevant information");
    }
    account_dal.addAcc(accountObj, function(err1, res1){
        if(err1){
            console.log("account insert broke");
            res.send(err1);
        }else{
            console.log("res3 successful");
            var account_id = res1.insertId;
            console.log("account_id" + account_id);
            var accountRelatedObj = {
                account_id: account_id,
                school_id: accountObj.school_id,
                company_id: accountObj.company_id,
                skill_id: accountObj.skill_id
            };
            console.log("accountRelatedObj + " + accountRelatedObj);
            account_dal.addAccSchool(accountRelatedObj,function(err2, res2){
                if(err2){
                    console.log("acc_school insert broke");
                    res.send(err2);
                }else{
                    console.log("res2 successful");
                    account_dal.addAccCompany(accountRelatedObj,function(err3, res3){
                        // BREAKS HERE, Undefined Company_id
                        if(err3){
                            console.log("acc_comp insert broke");
                            res.send(err3);
                        }else{
                            console.log("res3 successful");
                            account_dal.addAccSkill(accountRelatedObj, function(err4, res4){
                                if(err4){
                                    console.log("acc_skil insert broke");
                                    res.send(err4);
                                }else{
                                    console.log("successfully did all inserts");
                                    res.send("insert successful :)");
                                }
                            })
                        }
                    })

                }
            })
        }
    })
});

router.post('/all', function(req, res){ //never gets loaded unless is invoked with a post request
    console.log("post req called");
    console.log(req.body.account);//data passed in
    insert.universal("account", req.body.account, function(err, result){
        if(err){
            res.send(err);
        }else{
            res.redirect('/account/all');
        }
    });
});

router.get('/delete/:id', function(req, res){
    console.log(req.params.id);//req.params.id == :id(value passed in url)
    account_dal.delete(req.params.id, function(err, result){
        if(err){
            res.send(err);
        }else{
            res.redirect('/account/all');
        }
    });
});

router.post('/edit', function(req, res){
    console.log("post req called");
    console.log(req.body.account);//data passed in console.log("post req call")
    account_dal.edit(req.body.account, function(err, result){
        if(err){
            console.log("edit threw error");
            res.send(err);
        }else{
            res.redirect('/account/all');
        }
    });
});




module.exports = router;