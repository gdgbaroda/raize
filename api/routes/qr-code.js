var QRCode = require('qrcode');
const express = require('express');
const router = express.Router();
let axios = require('axios');
const sgMail = require('@sendgrid/mail');
sgMail.setApiKey('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');


router.get('/', function (req, res) {
    QRCode.toDataURL('I am a pony!', function (err, url) {
        var base64Data = url.replace(/^data:image\/png;base64,/, "");

        return res.render("index", {qrcode: url});
        // require("fs").writeFile("out.png", base64Data, 'base64', function (err) {
        //     console.log(err);
        // });
    })
});

router.get('/mail', function (req, res) {
    QRCode.toDataURL('I am a pony!', function (err, url) {
        var base64Data = url.replace(/^data:image\/png;base64,/, "");

        const msg = {
            to: 'dhruvil2111@gmail.com',
            from: 'tickets@gdgbaroda.com',
            subject: 'Sending with SendGrid is Fun',
            text: 'and easy to do anywhere, even with Node.js',
            attachments: [
                {
                    filename: "../out.png",
                    type: "image/png",
                    content: base64Data,
                    content_id: "myimagecid",
                    disposition: "inline"
                }
            ],
            html: '<strong>and easy to do anywhere, even with Node.js</strong>',
        };
        sgMail.send(msg);
    });
})

module.exports = router;
