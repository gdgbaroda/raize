const express = require('express');
const router = express.Router();
let axios = require('axios');
const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost:27017/raize', {useNewUrlParser: true});



module.exports = router;
