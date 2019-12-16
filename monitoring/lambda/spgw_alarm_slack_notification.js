var https = require('https');
var util = require('util');

exports.handler = function(event, context) {
    console.log(JSON.stringify(event, null, 2));
    var enviro = event.Records[0].Sns.Subject.split("__")[0].split("\"")[1];
    var subject = event.Records[0].Sns.Subject.split("__")[1];
    var channel = event.Records[0].Sns.Subject.split("__")[2].split("\"")[0];
    console.log("Slack channel: " + channel);

    var postData = {
        "channel": "# " + channel,
        "username": "AWS SNS via Lambda :: Alarm notification",
        "text": "_" + subject + "\\n"+enviro+" Environment_",
        "icon_emoji": ":aws:"
    };

    postData.attachments = [
        {
            "color": "Warning",
            "text": "```"+JSON.stringify(event.Records[0].Sns.Message,null,'\t')+"```"
        }
    ];

    var options = {
        method: 'POST',
        hostname: 'hooks.slack.com',
        port: 443,
        path: '/services/T02DYEB3A/BGJ1P95C3/f1MBtQ0GoI6kbGUztiSpkOut'
    };

    var req = https.request(options, function(res) {
      res.setEncoding('utf8');
      res.on('data', function (chunk) {
        context.done(null);
      });
    });

    req.on('error', function(e) {
      console.log('problem with request: ' + e.message);
    });

    req.write(util.format("%j", postData));
    req.end();
};