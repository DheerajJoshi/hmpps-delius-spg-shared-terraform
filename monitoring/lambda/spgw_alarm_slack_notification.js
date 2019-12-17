var https = require('https');
var util = require('util');

exports.handler = function(event, context) {
    console.log(JSON.stringify(event, null, 2));

    var eventMessage = JSON.parse(event.Records[0].Sns.Message);
    var alarmName = eventMessage.AlarmName;
    var alarmDescription = eventMessage.AlarmDescription;
    var newStateReason = eventMessage.NewStateReason;


    var environment = alarmName.split("__")[0];
    var service = alarmName.split("__")[1];
    var metric = alarmName.split("__")[2];
    var severity = alarmName.split("__")[3];


    var subChannelForEnvironment=(environment=='prod') ? "production" : "nonprod";

    var channel="delius-alerts-"+service+"-"+subChannelForEnvironment;

    var link_names=0;
    if (severity=='critical' || severity=='alert' && environment=='prod'){
       link_names=1;
    }



    //environment	service	    tier	metric	severity	resolvergroup(s)

    console.log("Slack channel: " + channel);

    var postData = {
        "channel": "# " + channel,
        "username": "AWS SNS via Lambda :: Alarm notification",
        "text": "Metric: "+subject +
        "\nEnvironment: "+environment+
        "\nSeverity: " + severity +
        "\nCause: "+newStateReason,
        "\nAction: "+alarmDescription+
        "icon_emoji": ":twisted_rightwards_arrows:",
        "link_names":"1"
    };

    postData.attachments = [
        {
            "color": "Warning",
            "text": "Resolvers: "+
            "<@UEPGCM2UC> " +//Semenu
            "<@U6YSHKNBS> " +//Paul
            "<@U6CNGECSG> " +//Mark
            JSON.stringify(eventMessage,null,'\t')+"```"
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