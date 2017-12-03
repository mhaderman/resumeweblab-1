var express = require('express');
var router = express.Router();
var resume_dal = require('../model/resume_dal');
var insert = require('../model/Universal');

router.get('/add/selectuser', function(req, res){
    resume_dal.getAll(function(err, response){
        console.log(response);
        res.render("resume/resumeViewAll", {response: response});
    });
});

router.get('/change/:id')