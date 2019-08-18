const express = require('express');
const router = express.Router();
let axios = require('axios');
const mongoose = require('mongoose');
let config = require('../config/config');
const passport = require('passport');
let MeetupOAuth2Strategy = require('passport-oauth2-meetup').Strategy;


mongoose.connect(config.MONGODB_CONNECTION, {useNewUrlParser: true});

passport.use(new MeetupOAuth2Strategy({
    clientID: config.MEETUP_CLIENT_ID,
    clientSecret: config.MEETUP_CLIENT_SECRET,
    callbackURL: config.MEETUP_CALLBACK_URL,
}, function (accessToken, refreshToken, profile, done) {
    return done(null, profile);
}));

//for authentication on meetup
router.get('/auth',
    passport.authenticate('meetup', {session: true}),
    function (req, res) {
        return res.json(req.user);
    });

//for authentication on meetup callback
router.get('/callback', function (req, res) {
    axios.post('https://secure.meetup.com/oauth2/access', {}, {
        params: {
            client_id: config.MEETUP_CLIENT_ID,
            client_secret: config.MEETUP_CLIENT_SECRET,
            grant_type: 'authorization_code',
            redirect_uri: config.MEETUP_CALLBACK_URL,
            code: req.query.code
        }
    }).then((data) => {
        req.flash("user", data.data);
        req.session.user = data.data;
        return res.json(data.data)

    }).catch((error) => {
        // console.error(error)
    });
});

//fetching groups of authenticated user
router.get('/groups', function (req, res) {
    let user = req.flash("user");
    // let access_token = user[0].access_token;
    let access_token = req.session.user.access_token;
    axios.get('https://api.meetup.com/self/groups', {
        headers: {
            Authorization: "Bearer " + access_token,
        }
    }).then((data) => {

        return res.json(data.data)

    }).catch((error) => {
        console.error(error)
    });


});

//fetching events of a group
router.get('/:urlname/', function (req, res) {
    let user = req.flash("user");
    // let access_token = user[0].access_token;
    let access_token = req.session.user.access_token;

    axios.get(`https://api.meetup.com/${req.params.urlname}/events`, {
        headers: {
            Authorization: "Bearer " + access_token,
        }
    }).then((data) => {
        return res.json(data.data)
    }).catch((error) => {
        console.error(error)
    });
});

//fetching rsvp of an event
router.get('/:urlname/:event_id/rsvp', function (req, res) {
    let user = req.flash("user");
// let access_token = user[0].access_token;
    let access_token = req.session.user.access_token;

    axios.get(`https://api.meetup.com/${req.params.urlname}/events/${req.params.event_id}/rsvps`, {
        headers: {
            Authorization: "Bearer " + access_token,
        }
    }).then((data) => {
        return res.json(data.data)
    }).catch((error) => {
        console.error(error)
    });

});


module.exports = router;
