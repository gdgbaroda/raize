const swaggerUi = require('swagger-ui-express');
const swaggerJsdoc = require('swagger-jsdoc');

const options = {
    swaggerDefinition: {
        info: {
            title: 'Raize Api',
            version: '1.0.0',
            description: 'Raize Api is a wrapper for meetup.com, allows organizers to check in attendees for an event'
        },
        basePath:'/meetup'
    },
    apis:['./routes/meetup.js']
};

const specs = swaggerJsdoc(options);

module.exports = (app) => {
    app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(specs));
}