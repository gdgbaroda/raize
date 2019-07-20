var createError = require('http-errors');
var express = require('express');
var path = require('path');
var flash = require('connect-flash');

var session = require('express-session');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var config = require('./config/config');
var meetupAuthRouter = require('./routes/meetup-auth');
var meetupGroupList = require('./routes/meetup-groups-list');
var meetupEventsList = require('./routes/meetup-event-list');


var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({extended: false}));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(session({
    cookie: {maxAge: 60000},
    secret: 'woot',
    resave: false,
    saveUninitialized: false
}));
app.use(flash());


app.use('/', meetupAuthRouter);
app.use('/meetup/me/groups', meetupGroupList);
app.use('/meetup/events', meetupEventsList);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
    next(createError(404));
});


// error handler
app.use(function (err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error');
});

app.listen(80, function () {
    console.log('localhost running on 80', config.NODE_ENV)
});

module.exports = app;
