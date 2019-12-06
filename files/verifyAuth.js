var http = require('http');
exports.handler = function (event, context) {

    console.log('Received verify event:', JSON.stringify(event, challengeAnswerReplacer));	
    console.log('Received verify context:', JSON.stringify(context, null, 2));

    VerifyCredentials(event, function (status) {
        if (status === true) {
            event.response.answerCorrect = true;
            console.log('answer:', JSON.stringify(event.response.answerCorrect));

        } else {
            event.response.answerCorrect = false;
        }
        context.done(null, event);

    });

};

function challengeAnswerReplacer(key, value) 
{
  if (key == 'challengeAnswer') {
    return 'REMOVED';
  }
  
  return value;
}

function bodyReplacer(key, value) 
{
  if (key == 'body') {
    return 'REMOVED';
  }
  
  return value;
}

function VerifyCredentials(event, completedCallback) {
    console.log("VerifyCredentials called ");
    console.log(JSON.stringify(event.response));
    console.log("ALB_URL = ", process.env.ALB_URL);

    var answer = JSON.parse(event.request.challengeAnswer);

    var userInfo = {
        "username": event.userName,
        "password": answer.Password,
        "impersonationRole": answer.ImpersonationRole
    };


    var options = {
        host:  process.env.ALB_URL, //process.env.SERVICE_HOST,,      
        path:  '/v1.0/authentication/verify-credentials', //process.env.SERVICE_PATH,,
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(userInfo)
    };

    console.log("setting up request: ");
    console.log(JSON.stringify(options, bodyReplacer));
    var req = http.request(options, function (res) {
        console.log("statusCode: ", res.statusCode);
        var respstring = '';
        res.on('data', function (chunk) {
            respstring += chunk;
        });

        res.on('end', function () {
            console.log("respstring: ", respstring);
            var verified = JSON.parse(respstring);
            console.log("verified: ", verified);

            completedCallback(verified);

        });

    });

    req.on('error', function (e) {
        console.log('HTTP error', e.message);

    });

    req.write(JSON.stringify(userInfo));

    req.end();


}
