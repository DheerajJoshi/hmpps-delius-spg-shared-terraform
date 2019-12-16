var https = require('https');
var util = require('util');

exports.handler = function(event, context) {
    console.log(JSON.stringify(event, null, 2));
    var environment = event.Records[0].Sns.Subject.split("__")[0].split("\"")[1];
    var subject = event.Records[0].Sns.Subject.split("__")[1];
    var channel = event.Records[0].Sns.Subject.split("__")[2].split("\"")[0];

    var eventMessage = JSON.parse(event.Records[0].Sns.Message);
    var alarmDescription = eventMessage.AlarmDescription;
    var newStateReason = eventMessage.NewStateReason;

    console.log("Slack channel: " + channel);

    var postData = {
        "channel": "# " + channel,
        "username": "AWS SNS via Lambda :: Alarm notification",
        "text": subject + "\n_Environment: "+environment+"_"+"\nAlarm: "+alarmDescription+"\nReason: "+newStateReason,
        "icon_emoji": ":twisted_rightwards_arrows:",
        "link_names":"1"
    };

    postData.attachments = [
        {
            "color": "Warning",
            "text": "<@UEPGCM2UC> <@Mark Butler> @delius-aws-migration-standup ```"+JSON.stringify(eventMessage,null,'\t')+"```"
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