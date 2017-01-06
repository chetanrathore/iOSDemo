var express = require('express');
var bodyParser = require('body-parser');
var settings = require('./settings.js');
var path = require('path');
var connection = require('./connection.js');
var app = express();
var server = require("http").Server(app);

app.use(bodyParser.json())
app.use(bodyParser.json({limit:'50mb'}));
app.use(bodyParser.urlencoded({limit:'50mb',extended:true}));

connection.init();


app.get('/',function(req, res) {
    res.send({msg:'success........'});
});

//define routes
app.use(require('./routes/index'));

app.set('port',process.env.PORT || settings.webPort);
app.use(express.static(path.join(__dirname,'public')));

server.listen(app.get('port'),function(){
    console.log('Server listing at port ' + server.address().port);
});

module.express=app;