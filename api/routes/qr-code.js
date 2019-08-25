var QRCode = require('qrcode');
const express = require('express');
const router = express.Router();
let axios = require('axios');
const sgMail = require('@sendgrid/mail');
sgMail.setApiKey('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');


router.get('/', function (req, res) {
    let id = req.query.id;
    QRCode.toDataURL(id, function (err, url) {
        var base64Data = url.replace(/^data:image\/png;base64,/, "");

        return res.render("index", {qrcode: url});
        // require("fs").writeFile("out.png", base64Data, 'base64', function (err) {
        //     console.log(err);
        // });
    })
});

router.get('/mail', function (req, res) {
    let id = req.query.id;
    QRCode.toDataURL(id, function (err, url) {
        var base64Data = url.replace(/^data:image\/png;base64,/, "");
        require("fs").writeFile('qrcodes/' + id + '.png', base64Data, 'base64', function (err) {
            const msg = {
                to: 'dhruvil2111@gmail.com',
                from: 'tickets@gdgbaroda.com',
                subject: 'GDG Baroda Dev-fest Ticket.',
                text: 'GDG Baroda Dev-fest Ticket',
                attachments: [
                    {
                        filename: id + '.png',
                        type: "image/png",
                        content: base64Data,
                        content_id: "myimagecid",
                        disposition: "inline"
                    }
                ],
                html: '<strong>Please download your ticket.</strong>',
            };
            sgMail.send(msg);
        });
    });
})

module.exports = router;
