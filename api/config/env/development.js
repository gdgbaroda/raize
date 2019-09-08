var envFile = __dirname + '/env.json';
var jsonfile = require('jsonfile');

var envVars = jsonfile.readFileSync(envFile);

module.exports = {
    MEETUP_CLIENT_ID: envVars["MEETUP_CLIENT_ID"],
    MEETUP_CLIENT_SECRET: envVars["MEETUP_CLIENT_SECRET"],
    MEETUP_CALLBACK_URL: envVars["MEETUP_CALLBACK_URL"],
    NODE_ENV: envVars["NODE_ENV"],
    MONGODB_CONNECTION: envVars["MONGODB_CONNECTION"],
};
