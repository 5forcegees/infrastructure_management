exports.handler = (event, context, callback) => {
    //auto confirm users created in cognito as a pre sign up process
    event.response.autoConfirmUser = true;
    context.done(null, event);
};