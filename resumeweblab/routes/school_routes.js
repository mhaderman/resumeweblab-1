var express = require('express');
var router = express.Router();
var insert = require('../model/Universal');
var school_dal = require('../model/school_dal');

router.get('/all', function(req, res) {
    school_dal.getAll(function (err, response) {
        console.log(response);
        res.render("school/schoolViewAll", {response: response});
    });
});

router.post('/all', function(req, res){
    console.log("post req called");
    console.log(req.body.school);
    insert.Universal("school", req.body.school, function(err, result){
        if(err){
            res.send(err);
        }else{
            res.redirect('/school/all');
        }
    });
});

router.get('/delete/:name', function(req, res){
    console.log(req.params.name);
    school_dal.delete(req.params.name, function(err, result){
        if(err){
            res.send(err);
        }else{
            res.redirect('/school/all');
        }
    });
});

router.post('/edit', function(req,res){
    console.log("post req called");
    console.log(req.body.school);
    school_dal.edit(req.body.school, function(err, result){
        if(err){
            console.log("Query" + query);
            console.log("edit threw error");

        }else{
            res.redirect('/school/all');
        }
    });
});
module.exports = router;
