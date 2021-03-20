const
        express = require('express'),
        exphbs = require('express-handlebars'),
        bodyParser = require('body-parser'),
        morgan = require('morgan'),
        session = require('express-session'),

app = express();

app.use(express.static(__dirname + '/public'));


var server = app.listen(process.env.PORT || 8001, function () {
    var host = server.address().address;
    var port = server.address().port;
    console.log('App listening at http://' + host + ':' + port);
});

app.use(morgan('dev'));
app.use(bodyParser.urlencoded({extended: false}));
