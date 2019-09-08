const csv = require('csv-parser');
const fs = require('fs');
const createCsvWriter = require('api/helpers/csv-writer').createObjectCsvWriter;
var methods = {};

methods.CreateCSV = async function (data) {
    let today = new Date();
    let date = today.getDate() + '-' + (today.getMonth() + 1) + '-' + today.getFullYear();
    let path = `./data/${date}.csv`;
    if (!fs.existsSync(path)) {
        const csvWriter = createCsvWriter({
            path: path,
            header: [
                {id: 'event', title: 'EVENT'},
                {id: 'payment_id', title: 'PAYMENT ID'},
                {id: 'name', title: 'NAME'},
                {id: 'email', title: 'EMAIL'},
                {id: 'check_in', title: 'CHECK IN'}
            ]
        });
        var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
        var dateTime = date + ' ' + time;
        const records = [
            {
                event: data['payment']['link_title'],
                payment_id: data['payment']['payment_id'],
                name: data['payment']['buyer_name'],
                email: data['payment']['buyer_email'],
                check_in: dateTime,
            },
        ];

        csvWriter.writeRecords(records)       // returns a promise
            .then(() => {
                console.log('...Done');
            });
    }

};

exports.data = methods;