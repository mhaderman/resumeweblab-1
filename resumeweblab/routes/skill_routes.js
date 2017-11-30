var express = require('express');
var router = express.Router();
var insert = require('../model/Universal');
var skill_dal = require('../model/skill_dal');

router.get('/all', function(req, res) {
    skill_dal.getAll(function (err, response) {
        console.log(response);
        res.render("skill/skillViewAll", {response: response});
    });
});

router.post('/all', function(req, res){
    console.log("post req called");
    console.log(req.body.skill);
    insert.Universal("skill", req.body.skill, function(err, result){
        if(err){
            res.send(err);
        }else{
            res.redirect('/skill/all');
        }
    });
});

router.get('/delete/:id', function(req, res){
    console.log(req.params.id);
    skill_dal.delete(req.params.id, function(err, result){
        if(err){
            res.send(err);
        }else{
            res.redirect('/skill/all');
        }
    });
});

router.post('/edit', function(req,res){
    console.log("post req called");
    console.log(req.body.skill);
    skill_dal.edit(req.body.skill, function(err, result){
        if(err){
            console.log("edit threw error");

        }else{
            res.redirect('/skill/all');
        }
    });
});
module.exports = router;
