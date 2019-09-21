const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const AttendeeSchema = new Schema({
    event: String,
    payment_id: String,
    name: String,
    email: String,
    date_time: String,
});

module.exports = mongoose.model('Attendee', AttendeeSchema);
