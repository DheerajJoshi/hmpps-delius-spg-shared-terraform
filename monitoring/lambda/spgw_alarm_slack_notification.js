var https = require('https');
var util = require('util');

exports.handler = function(event, context) {
    console.log(JSON.stringify(event, null, 2));

    var eventMessage = JSON.parse(event.Records[0].Sns.Message);
    var alarmName = eventMessage.AlarmName;
    var alarmDescription = eventMessage.AlarmDescription;
    var newStateReason = eventMessage.NewStateReason;
    var comparisonOperator = eventMessage.Trigger.ComparisonOperator;
    var threshold = eventMessage.Trigger.Threshold;
    var metricName= eventMessage.Trigger.MetricName;



    var environment = alarmName.split("__")[0];
    var service = alarmName.split("__")[1];
    var metric = alarmName.split("__")[2];
    var severity = alarmName.split("__")[3];
    if (eventMessage.NewStateValue == "OK")
        severity='ok';

    if (eventMessage.NewStateValue == "INSUFFICIENT_DATA")
        severity='insufficient data';



    var subChannelForEnvironment=(environment=='del-prod') ? "production" : "nonprod";

    var channel="delius-alerts-"+service+"-"+subChannelForEnvironment;


    var resolvers = ""


    if (severity=='fatal' || severity=='critical' && environment=='del-prod'){
            resolvers="\n\nNotified:"
            +"<@UEPGCM2UC> " //Semenu
            +"<@U6YSHKNBS> " //Paul
            +"<@U6CNGECSG> " //Mark

    }

    var icon_emoji=":twisted_rightwards_arrows:";

    if (severity=='warning' )
        icon_emoji = ":heavy_tick:";


    if (severity=='warning' )
        icon_emoji = ":warning:";


    if (severity=='critical' )
        icon_emoji = ":siren:";

    if (severity=='fatal' )
       icon_emoji = ":alert:";



    console.log("Slack channel: " + channel);

    var debug="";
//    var debug="\n\ndebug:```eventMessage```";

    var textMessage="**************************************************************************************************"
                            +"\nMetric: " + metric
                            + "\nEnvironment: " + environment
                            + "\nSeverity: " + icon_emoji+severity;


     if (severity=='warning' || severity=='critical' || severity=='fatal')

     { textMessage=textMessage
          + "\nMetricName: " + metricName;
          + "\nComparisonOperator: " + comparisonOperator;
          + "\nThreshold: " + threshold;
          + "\n\nAction: " + alarmDescription
          + resolvers;
     }
    textMessage=textMessage+debug;



    var postData = {
        "channel": "# " + channel,
        "username": "AWS SNS via Lambda :: Alarm notification",
        "text": textMessage,
        "icon_emoji": icon_emoji,
        "link_names": "1"
    };

    postData.attachments = [
        {
            "color": "Warning",
            "text":  "\n```"+JSON.stringify(eventMessage,null,'\t')+"```"
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