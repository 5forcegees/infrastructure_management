exports.handler = function(event, context) {
    
    console.log('Received event:', JSON.stringify(event, null, 2));
    console.log('Received context:', JSON.stringify(context, null, 2));
       
    event.response.issueTokens = false;
    event.response.failAuthentication = false;
    
    event.response.challengeName = 'CUSTOM_CHALLENGE';
    
    if (event.request.session.length == 1) {
        if(event.request.session[0].challengeName == 'CUSTOM_CHALLENGE' && event.request.session[0].challengeResult == true) {
            event.response.issueTokens = true;
            event.response.failAuthentication = false;
        } else {
            event.response.issueTokens = false;
            event.response.failAuthentication = true;
        }
    }
    //
    context.done(null, event);
}