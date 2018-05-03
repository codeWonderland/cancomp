var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var pool = mysql.createPool({
    connectionLimit : 10000, // default = 10
    host            : 'localhost',
    user            : 'canCompAdmin',
    password        : 'candomble',
    database        : 'cancomp'
});

/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('index', { title: 'Express' });
});

router.get('/getSpirits', function(req, res, next) {
    pool.getConnection(function(err, con) {
        if (err) throw err;
        console.log('Connected!'); // Currently getting an error on sql queries
        con.query('call cancomp.get_spirits();'
            , function (err, result) {
                if (err)
                {
                    console.log('Error grabbing spirits: ' + err);
                    res.send('Error grabbing spirits');
                }
                res.send(result);
            })
    });
});

router.get('/spirit/:sid', function(req, res, next) {
    res.render('spirit', { id: req.params["sid"]})
});

router.get('/getSpirit', function(req, res, next) {
    pool.getConnection(function(err, con) {
        if (err) throw err;
        console.log('Connected!'); // Currently getting an error on sql queries
        con.query('call cancomp.get_spirit(\'' + req.get('spirit') + '\');'
            , function (err, result) {
                if (err)
                {
                    console.log('Error grabbing spirit: ' + err);
                    res.send('Error grabbing spirit');
                }
                res.send(result);
            })
    });
});

router.get('/getPseudonyms', function(req, res, next) {
    pool.getConnection(function(err, con) {
        if (err) throw err;
        console.log('Connected!'); // Currently getting an error on sql queries
        con.query('call cancomp.get_pseudonyms(\'' + req.get('spirit') + '\');'
            , function (err, result) {
                if (err)
                {
                    console.log('Error grabbing spirit: ' + err);
                    res.send('Error grabbing spirit');
                }
                res.send(result);
            })
    });
});

router.get('/getRelationships', function(req, res, next) {
    pool.getConnection(function(err, con) {
        if (err) throw err;
        console.log('Connected!'); // Currently getting an error on sql queries
        con.query('call cancomp.get_relationships(\'' + req.get('spirit') + '\');'
            , function (err, result) {
                if (err)
                {
                    console.log('Error grabbing spirit: ' + err);
                    res.send('Error grabbing spirit');
                }
                res.send(result);
            })
    });
});

router.get('/getSignificance', function(req, res, next) {
    pool.getConnection(function(err, con) {
        if (err) throw err;
        console.log('Connected!'); // Currently getting an error on sql queries
        con.query('call cancomp.get_significance(\'' + req.get('spirit') + '\');'
            , function (err, result) {
                if (err)
                {
                    console.log('Error grabbing spirit: ' + err);
                    res.send('Error grabbing spirit');
                }
                res.send(result);
            })
    });
});

module.exports = router;
