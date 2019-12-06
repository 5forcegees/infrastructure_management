exports.handler = function (event, context) {

    console.log('Received event:', JSON.stringify(event, null, 2));
    console.log('Received context:', JSON.stringify(context, null, 2));

    if (event.request.challengeName == 'CUSTOM_CHALLENGE') {
        event.response.publicChallengeParameters = {};
        event.response.publicChallengeParameters.captchaUrl = 'url/123.jpg'
        event.response.privateChallengeParameters = {};
        event.response.privateChallengeParameters.answer = '5';
        event.response.challengeMetadata = 'CAPTCHA_CHALLENGE';
    }

    context.done(null, event);
}