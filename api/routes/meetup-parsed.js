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

/**
 * @swagger
 * /callback:
 *    get:
 *      description: Handle callback for the authorized meetup user
 */
router.get('/callback', function (req, res) {

    if (req.query == {})
        return res.json(false);

    if (req.query.code == undefined)
        return res.json(false);

    // ensure the query parameter has a value
    if (req.query.code != '')
        return res.json(true);

    return res.json(false);
});

/**
 * @swagger
 * /callback/token:
 *    get:
 *      description: Explicitly obtain access token for the meetup user
 */
router.get('/callback/token', function (req, res) {
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
router.get('/groups', async function (req, res) {

    var bearerHeader = req.headers["authorization"];

    let parsed_group_data = [];
    let parsed_events_data = [];
    let i = 0;

    await axios.get('https://api.meetup.com/self/groups', {
        headers: {
            Authorization: bearerHeader
        }
    }).then(async (groups) => {

        for(let group of groups.data)
        {
            let events = await GetEvents(group.urlname, bearerHeader)

            console.log('Events: ' + JSON.stringify(events))

            if(JSON.stringify(events) !== '[]')
            {
                parsed_group_data.push({
                    title: group.name,
                    source: "meetup",
                    location: group.localized_location,
                    events: events,
                    lastUpdatedOn: group.updated,
                    isActive: group.status,
                });
            }
        }

        return res.json({groups: parsed_group_data})

    }).catch((error) => {
        console.error(error)
    });

});

//fetching events of a group
router.get('/:urlname/', function (req, res) {
    
    var bearerHeader = req.headers["authorization"];

    axios.get(`https://api.meetup.com/${req.params.urlname}/events`, {
        headers: {
            Authorization: bearerHeader
        }
    }).then((data) => {
        return res.json(data.data)
    }).catch((error) => {
        console.error(error)
    });
});

//fetching rsvp of an event
router.get('/:urlname/:event_id/rsvp', function (req, res) {

    var bearerHeader = req.headers["authorization"];

    axios.get(`https://api.meetup.com/${req.params.urlname}/events/${req.params.event_id}/rsvps`, {
        headers: {
            Authorization: bearerHeader
        }
    }).then((data) => {
        return res.json(data.data)
    }).catch((error) => {
        console.error(error)
    });

});

async function GetEvents(urlname, tokenHeader) {
    try 
    {
        let parsed_events = [];

        const response = await axios.get(`https://api.meetup.com/${urlname}/events`, {
                            headers: {
                                Authorization: tokenHeader
                            }
                        });

        if(JSON.stringify(response.data) !== '[]')
        {
            for(let event of response.data)
            {
                let events_by_host = await GetEventsByHost(event.id, urlname, tokenHeader)

                console.log('event ' + JSON.stringify(event));

                if(JSON.stringify(events_by_host) !== '{}')
                {
                    parsed_events.push({

                        title: event.name,
                        host:true,
                        description: event.description,
                        venue: event.venue,
                        duration: event.duration,
                        isActive: true
    
                    })
                }
                else
                {
                    parsed_events.push({

                        title: event.name,
                        host:false,
                        description: event.description,
                        venue: event.venue,
                        duration: event.duration,
                        isActive: true
    
                    })
                }
            }
        }
        else
        {
            console.log('No events for ' + urlname);
        }

        return parsed_events;

    } catch (error) {
      console.error(error);
    }
}

async function GetEventsByHost(event_id, urlname, tokenHeader) {
    try 
    {
        let filtered_events = {};

        const response = await axios.get(`https://api.meetup.com/${urlname}/events/${event_id}/rsvps`, {
                        headers: {
                            Authorization: tokenHeader
                        }
                    });

        if(JSON.stringify(response.data) !== '[]')
        {
            // get profile for the logged in user
            let profile = await GetProfile(tokenHeader)

            // filter by member id
            var result = response.data.filter(function(obj, index){
                return obj.member.id === profile.id;
            })

            if(JSON.stringify(result) !== '[]')
            {
                for(let event of result)
                {
                    if(event.member.event_context.host === true)
                    {
                        filtered_events = {
                            id:event.event.id,
                            host:event.member.event_context.host
                        }
                    }
                    else
                    {
                        console.log('Is event host: ' + JSON.stringify(event.member.event_context.host))
                    }
                }
            }
        }
        else
        {
            console.log('No events for ' + urlname);
        }

        return filtered_events;

    } catch (error) {
      console.error(error);
    }
}

async function GetProfile(tokenHeader) {
    try 
    {
        const response = await axios.get(`https://api.meetup.com/members/self`, {
            headers: {
                Authorization: tokenHeader
            }
        });

        console.log('Member profile: ' + JSON.stringify(response.data))

        return response.data;

    } catch (error) {
      console.error(error);
    }
}

module.exports = router;