var express = require('express');
var router = express.Router();
var pg = require('pg');
var connectionString =  'postgres://postgres:postgres@localhost:5432/testnode';

/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('login', { title: 'library login' });
});

router.post('/submit',function(req,res,next)
{
    console.log("something works");
    var client = new pg.Client(connectionString);
    client.connect(function(err,client,done)
    {
        if(err)
        {
            console.log('Client connection error',err);
            res.send('Database error');
        }
        else{
            client.query('SELECT * from user_info WHERE user_name=$1 and password=$2',[req.body.rn,req.body.pw],function(err,result)
            {
                if(err)
                {
                    res.send('Database error');
                }
                else
                {
                    if(result.rows.length!=0)
                    {
                        var importantRow = result.rows[0];
                        if(importantRow.user_name==req.body.rn && importantRow.password==req.body.pw)
                        {
                            res.send('You have logged in successfully');
                        }
                        else
                        {
                            res.send('Incorrect username or password');
                        }
                    }
                    else
                    {
                        res.send('Incorrect username or password');
                    }
                    //res.send("testing");
                }
            });
        }
    });
});
router.post('/register',function(req,res,next)
{
    console.log("something else works");
    var client = new pg.Client(connectionString);
    client.connect(function(err,client,done)
    {
        if(err)
        {
            console.log('Client connection error',err);
            res.send('Database error');
        }
        else
        {
            client.query("INSERT INTO user_info(user_name,first_name,last_name,password) values($1, $2, $3, $4)", [req.body.rn, req.body.firstname, req.body.lastname,req.body.pw]);
            {
                if(err)
                {
                    res.send('Database error');
                }
                else
                {
                    console.log("something else works again ");
                    res.send('Hey sexy');
                 }
            }

        }
    });
});

module.exports = router;