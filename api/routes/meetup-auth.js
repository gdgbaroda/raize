const express = require('express');
const router = express.Router();
let axios = require('axios');
const mongoose = require('mongoose');
const passport = require('passport');
let MeetupOAuth2Strategy = require('passport-oauth2-meetup').Strategy;
let config = require('../config/config');
mongoose.connect(config.MONGODB_CONNECTION, {useNewUrlParser: true});

passport.use(new MeetupOAuth2Strategy({
    clientID: config.MEETUP_CLIENT_ID,
    clientSecret: config.MEETUP_CLIENT_SECRET,
    callbackURL: "http://localhost/",
}, function (accessToken, refreshToken, profile, done) {
    return done(null, profile);
}));

router.get('/auth/meetup',
    passport.authenticate('meetup', {session: true}),
    function (req, res) {
        return res.json(req.user);
    });

router.get('/', function (req, res) {
    axios.post('https://secure.meetup.com/oauth2/access', {}, {
        params: {
            client_id: config.MEETUP_CLIENT_ID,
            client_secret: config.MEETUP_CLIENT_SECRET,
            grant_type: 'authorization_code',
            redirect_uri: 'http://localhost',
            code: req.query.code
        }
    }).then((data) => {
        return res.json(data.data)
    }).catch((error) => {
        console.error(error)
    });
});


module.exports = router;
