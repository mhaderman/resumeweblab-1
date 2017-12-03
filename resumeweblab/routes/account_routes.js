var express = require('express');
var router = express.Router;
var insert = require('../model/Universal');
var account_dal = require('../model/account_dal');

router.get('/all', function(req, res){
    account_dal.getAll(function (err, response){
        console.log(response);
        res.render("account/accountViewAll", {response: response});
    });
});

/*router.post('/all', function(req, res){
    console.log("post req called");
    console.log(req.body.account);
    insert.Universal("account", req.body.account, function(err, result){
        if (err){
            res.send(err);
        }else{
            res.redirect('/account/all');
        }
    });
});*/
router.post('./insert', function(req, res){
    insert.insert('account', req.body.account);
    res.redirect('/account/all');
});

router.get('/delete/:id', function(req, res){
    console.log(req.params.id);
    account_dal.delete(req.params.id, function(err, result){
        if(err){
            res.send(err);
        }else{
            res.redirect('/account/all');
        }
    });
});

router.post('/edit', function(req,res){
    console.log("post req called");
    console.log(req.body.account);
    account_dal.edit(req.body.account, function(err, result){
        if(err){
            console.log("edit threw error");

        }else{
            res.redirect('/account/all');
        }
    });
});
module.exports = router;
