var express = require('express');
var router = express.Router();
var insert = require('../model/Universal');
var address_dal = require('../model/address_dal');

router.get('/all', function(req, res) {
    address_dal.getAll(function (err, response) {
        console.log(response);
        res.render("address/addressViewAll", {response: response});
    });
});

router.post('/all', function(req, res){
    console.log("post req called");
    console.log(req.body.address);
    insert.Universal("address", req.body.address, function(err, result){
        if(err){
            res.send(err);
        }else{
            res.redirect('/address/all');
        }
    });
});

router.get('/delete/:id', function(req, res){
    console.log(req.params.id);
    address_dal.delete(req.params.id, function(err, result){
        if(err){
            res.send(err);
        }else{
            res.redirect('/address/all');
        }
    });
});

router.post('/edit', function(req,res){
    console.log("post req called");
    console.log(req.body.address);
    address_dal.edit(req.body.address, function(err, result){
        if(err){
            console.log("edit threw error");
            res.send(err);

        }else{
            res.redirect('/address/all');
        }
    });
});
module.exports = router;
