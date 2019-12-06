/**
 * Stream events from AWS CloudWatch Logs to Splunk
 *
 * This function streams AWS CloudWatch Logs to Splunk using
 * Splunk's HTTP event collector API.
 *
 * Define the following Environment Variables in the console below to configure
 * this function to stream logs to your Splunk host:
 *
 * 1. SPLUNK_HEC_URL: URL address for your Splunk HTTP event collector endpoint.
 * Default port for event collector is 8088. Example: https://host.com:8088/services/collector
 *
 * 2. SPLUNK_HEC_TOKEN: Token for your Splunk HTTP event collector.
 * To create a new token for this Lambda function, refer to Splunk Docs:
 * http://docs.splunk.com/Documentation/Splunk/latest/Data/UsetheHTTPEventCollector#Create_an_Event_Collector_token
 */

'use strict';

const url = require('url');

const Logger = function Logger(config) {
    this.url = config.url;
    this.token = config.token;

    this.addMetadata = true;
    this.setSource = true;

    this.parsedUrl = url.parse(this.url);
    // eslint-disable-next-line import/no-dynamic-require
    this.requester = require(this.parsedUrl.protocol.substring(0, this.parsedUrl.protocol.length - 1));
    // Initialize request options which can be overridden & extended by consumer as needed
    this.requestOptions = {
        hostname: this.parsedUrl.hostname,
        path: this.parsedUrl.path,
        port: this.parsedUrl.port,
        method: 'POST',
        headers: {
            Authorization: `Splunk ${this.token}`,
        },
        rejectUnauthorized: false,
    };

    this.payloads = [];
};

// Simple logging API for Lambda functions
Logger.prototype.log = function log(message, context) {
    this.logWithTime(Date.now(), message, context);
};

Logger.prototype.logWithTime = function logWithTime(time, message, context) {
    const payload = {};

    if (Object.prototype.toString.call(message) === '[object Array]') {
        throw new Error('message argument must be a string or a JSON object.');
    }
    payload.event = message;

    // Add Lambda metadata
    if (typeof context !== 'undefined') {
        if (this.addMetadata) {
            // Enrich event only if it is an object
            if (message === Object(message)) {
                payload.event = JSON.parse(JSON.stringify(message)); // deep copy
                payload.event.awsRequestId = context.awsRequestId;
            }
        }
        if (this.setSource) {
            payload.source = `lambda:${context.functionName}`;
        }
    }

    payload.time = new Date(time).getTime() / 1000;

    this.logEvent(payload);
};

Logger.prototype.logEvent = function logEvent(payload) {
    this.payloads.push(JSON.stringify(payload));
};

Logger.prototype.flushAsync = function flushAsync(callback) {
    callback = callback || (() => {}); // eslint-disable-line no-param-reassign

    console.log('Sending event(s)');
    const req = this.requester.request(this.requestOptions, (res) => {
        res.setEncoding('utf8');

        console.log('Response received');
        res.on('data', (data) => {
            let error = null;
            if (res.statusCode !== 200) {
                error = new Error(`error: statusCode=${res.statusCode}\n\n${data}`);
                console.error(error);
            }
            this.payloads.length = 0;
            callback(error, data);
        });
    });

    req.on('error', (error) => {
        callback(error);
    });

    req.end(this.payloads.join(''), 'utf8');
};

const zlib = require('zlib');

const loggerConfig = {
    url: process.env.SPLUNK_HEC_URL,
    token: process.env.SPLUNK_HEC_TOKEN,
};
const logger = new Logger(loggerConfig);

exports.handler = (event, context, callback) => {
    console.log('Received event:', JSON.stringify(event, null, 2));

    // CloudWatch Logs data is base64 encoded so decode here
    const payload = new Buffer(event.awslogs.data, 'base64');
    // CloudWatch Logs are gzip compressed so expand here
    zlib.gunzip(payload, (err, result) => {
        if (err) {
            callback(err);
        } else {
            const parsed = JSON.parse(result.toString('ascii'));
            console.log('Decoded payload:', JSON.stringify(parsed, null, 2));

            if(parsed.logGroup.startsWith("/aws/")) {
                var logGroupArr = parsed.logGroup.split("/");
                var hostType = `Microservice ${logGroupArr[2]}`;
                var sourceName = logGroupArr[3];
                var msEnv = sourceName.split("-")[1];
            } else {
                var sourceName = parsed.logGroup
                var logGroupArr = parsed.logGroup.split("-");
                var msEnv = logGroupArr[0];
                var msName = logGroupArr[1];
                var hostType = `Fargate Microservice`;
            }

            let count = 0;
            if (parsed.logEvents) {
                parsed.logEvents.forEach((item) => {
                    /* Log event to Splunk with explicit event timestamp.
                    - Use optional 'context' argument to send Lambda metadata e.g. awsRequestId, functionName.
                    - Change "item.timestamp" below if time is specified in another field in the event.
                    - Change to "logger.log(item.message, context)" if no time field is present in event. */
                    //logger.logWithTime(item.timestamp, item.message, context);

                    /* Alternatively, UNCOMMENT logger call below if you want to override Splunk input settings */
                    /* Log event to Splunk with any combination of explicit timestamp, index, source, sourcetype, and host.
                    - Complete list of input settings available at http://docs.splunk.com/Documentation/Splunk/latest/RESTREF/RESTinput#services.2Fcollector */
                     logger.logEvent({
                         time: new Date(item.timestamp).getTime() / 1000,
                         host: hostType,
                         source: sourceName,
                         sourcetype: msEnv,
                         index: 'awslambda',
                         event: item.message,
                     });

                    count += 1;
                });
            }
            // Send all the events in a single batch to Splunk
            logger.flushAsync((error, response) => {
                if (error) {
                    callback(error);
                } else {
                    console.log(`Response from Splunk:\n${response}`);
                    console.log(`Successfully processed ${count} log event(s).`);
                    callback(null, count); // Return number of log events
                }
            });
        }
    });
};

