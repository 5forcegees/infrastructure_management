// disable eslint's no-var rules for top-level declarations to take adv of lambda reuse
/* eslint-disable no-var */
var http = require('http');
/* eslint-enable no-var */

function proxyRequest(event, options) {
  // console.log(`request options to backend: ${JSON.stringify(options)}`);
  return new Promise((resolve, reject) => {
    if ( process.env.custom_cloudfront_token_key !== "NONE" && process.env.custom_cloudfront_token_value !== "NONE") {
      if (!event.headers[process.env.custom_cloudfront_token_key] || event.headers[process.env.custom_cloudfront_token_key] !== process.env.custom_cloudfront_token_value) {
        console.log('Cloudfront token not found or not matching')
        resolve({
          statusCode: 404,
          headers: event.headers,
          body: '',
          isBase64Encoded: false
        });
      }
    }

    const req = http.request(options, (res) => {
      let responseString = '';
      res.on('data', (chunk) => {
        responseString += chunk;
      });

      res.on('end', () => {

        // The 3rd party ec2 windows instance has Dynatrace installed.
        // Dynatrace add 'set-cookie': [ 'dtCookie=1$87167316EC18765DF057E8BAD821F223; Path=/; Domain=.amazonaws.com' ]
        // and cause https://aws.amazon.com/premiumsupport/knowledge-center/malformed-502-api-gateway/

        delete res.headers['set-cookie'];
        resolve({
          statusCode: res.statusCode,
          headers: res.headers,
          body: responseString,
          isBase64Encoded: res.headers.isbase64encoded || false,
        });
      });
    });

    // if POSTING data, write it
    if (event.body && event.body !== '') {
      req.write(event.body);
    }

    req.on('error', (e) => {
      // console.log(`Error on request: ${JSON.stringify(e)}`);
      reject(new Error(JSON.stringify(e)));
    });

    req.end();
  });
}

function generateQueryStrings(event) {
  let queryStrings = '';
  const params = event.queryStringParameters;

  if (params && Object.keys(params).length > 0) {
    const str = [];
    Object.keys(params).forEach((key) => {
      str.push(`${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`);
    });
    queryStrings = `?${str.join('&')}`;
  }
  return queryStrings;
}

function generateHeaders(event) {
  let { headers } = event;
  if (!headers || Object.keys(headers).length <= 0) {
    headers = {};
  }

  // set headers
  headers['User-Agent'] = event.requestContext.identity.userAgent;
  headers['X-Forwarded-For'] = event.requestContext.identity.sourceIp;

  return headers;
}

function generateRequestOptions(event) {
  const options = {
    protocol: 'http:',
    host: process.env.ALB_URL,
    port: 80,
    path: event.path,
    method: event.httpMethod,
  };

  options.headers = generateHeaders(event);
  options.path += generateQueryStrings(event);

  return options;
}

function apigwProxy(event, callback) {
  // console.log(`inbound request: ${JSON.stringify(event)}`);
  const options = generateRequestOptions(event);
  // const reqCallback = generateRequestCallback(callback);
  return proxyRequest(event, options)
    .then((data) => {
      callback(null, data);
    })
    .catch((err) => {
      callback(err);
    });
}

function handler(event, context, callback) {
  apigwProxy(event, callback);
}

module.exports = {
  handler,
  generateRequestOptions,
  generateHeaders,
  generateQueryStrings,
  proxyRequest,
};



