import boto3
import os
import json
import time
import re
import sys
from dateutil import tz
from datetime import datetime,time
from botocore.exceptions import ClientError

def lambda_handler(event, context):
	
	#For debugging so you can see raw event format.
	print('Here is the event:')
	print(json.dumps(event))
	
	global received_event
	received_event = event
	
	parse_event()
	#Email is currently unsupported at client, pending security Approval of SES
	#email_users()
	text_users()

def parse_event():
	global alarm_level
	global notification_level
	global alarm_name
	global alarm_env
	global alarm_type
	global alarm_desc
	global alarm_state
	global alarm_old_state
	global alarm_reason
	global alarm_time
	global alarm_level
	global notification_level
	
	try:
		alarm_message = received_event['Records'][0]['Sns']['Message']
		alarm_message = json.loads(alarm_message)
		alarm_name = alarm_message['AlarmName']
		alarm_desc = alarm_message['AlarmDescription']
		alarm_state = alarm_message['NewStateValue']
		alarm_old_state = alarm_message['OldStateValue']
		alarm_reason = alarm_message['NewStateReason']
		alarm_time = alarm_message['StateChangeTime']
	except KeyError:
		print('Lambda function was not invoked by an expected CloudWatch Alarm.  Appropriate Fields are not available in Message.')
		sys.exit()
	alarm_name_array = alarm_name.split('-')
	
	# Some environment names contain a '-', in particular the feature environments
	# We must therefore combine these fields to get the proper environment
	if alarm_name_array[2]=='ft':
		alarm_name_array.pop(2)
		alarm_name_array[1]=alarm_name_array[1]+'-ft'

	alarm_env = alarm_name_array[1]
	alarm_type = alarm_name_array[2]

	if alarm_type=='increasing':
		alarm_level = 'Low'
		notification_level = 'Platform'
	elif alarm_type=='high':
		alarm_level = 'Medium'
		notification_level = 'General'
	elif alarm_type=='critical':
		alarm_level = 'High'
		notification_level = 'NOC'
	else:
		alarm_level = 'Other'
		notification_level = 'Platform'

def email_users():
	
	email_parameter_store_key = '/CI/MS/' + alarm_env + '/Platform/Email/' + notification_level + 'NotificationList'

	ssm_email = boto3.client('ssm', region_name='us-west-2')
	response = ssm_email.get_parameters(
		Names=[email_parameter_store_key], WithDecryption=True
	)

	recipients = response['Parameters'][0]['Value']

	print('I will send emails to: '+recipients)
	print('The subject would be: '+'['+alarm_state+'] '+alarm_env.capitalize()+' - '+alarm_level.capitalize()+' ('+alarm_name+')')


	sender = "Microservice Alarms <my.name@client.com>"
	subject = '['+alarm_level.capitalize()+'] '+alarm_env.capitalize()+' Microservice AWS Alarm ('+alarm_name+')'
	
	# The email body for recipients with non-HTML email clients.
	body_text = ("Currently the Microservice AWS environment is encountering issues which have triggered an alarm.  Please review the below details and take any necessary actions:\r\n"
	             "Alarm Name: " + alarm_name +"\r\n"
	             "Alarm Description: " + alarm_desc +"\r\n"
	             "Alarm Environment: " + alarm_env +"\r\n"
	             "Alarm Level: " + alarm_level +"\r\n"
	             "Alarm State: " + alarm_state +"\r\n"
	             "Alarm Reason: " + alarm_reason +"\r\n"
	             "Alarm Time: " + alarm_time +"\r\n"
	            )
	            
	# The HTML body of the email.
	body_html_template = """<html>
	<body>
	<p>Currently the Microservice AWS environment is encountering issues which have triggered a CloudWatch alarm.  Please note the above severity, review the below details and take any necessary actions.</p>
	  <h1>Alarm Details</h1>
	  <p>Here are the details for the current alarm:
	    <ul>
	    	<li><strong>Alarm Name</strong>: {}</li>
	    	<li><strong>Alarm Description</strong>: {}</li>
	    	<li><strong>Alarm Environment</strong>: {}</li>
	    	<li><strong>Alarm Level</strong>: {}</li>
	    	<li><strong>Alarm State</strong>: {} (Old State: {} )</li>
	    	<li><strong>Alarm Reason</strong>: {}</li>
	    	<li><strong>Alarm Time</strong>: {}</li>
	    </ul>
	  </p>
	   <h1>Next Steps</h1>
	   <p>Please take the necessary actions and reply-all to this message with relevant updates.  If the issue continues and breaks additional alarm threshold, this issue may be escalated further.  Please be aware that additional levels of management and the NOC may be included on additional levels of escalation.</p>
	</body>
	</html>
	            """            

	body_html = body_html_template.format(alarm_name,alarm_desc,alarm_env.capitalize(),alarm_level.capitalize(),alarm_state,alarm_old_state,alarm_reason,alarm_time)
	# The character encoding for the email.
	charset = "UTF-8"


	ses = boto3.client('ses')

	# Try to send the email.
	try:
	    #Provide the contents of the email.
	    response = ses.send_email(
	        Destination={
	            'ToAddresses': [
	                'my.name@client.com',
	            ],
	        },
	        Message={
	            'Body': {
	                'Html': {
	                    'Charset': charset,
	                    'Data': body_html,
	                },
	                'Text': {
	                    'Charset': charset,
	                    'Data': body_text,
	                },
	            },
	            'Subject': {
	                'Charset': charset,
	                'Data': subject,
	            },
	        },
	        Source=sender,
	    )
	# Display an error if something goes wrong.	
	except ClientError as e:
	    print(e.response['Error']['Message'])
	else:
	    print("Email sent! Message ID:"),
	    print(response['MessageId'])
	
	
def text_users():
	
	PST=tz.gettz('Pacific Standard Time')
	#Currently we will determine whether an AM or PM shift list should be notified
	if time(10,0,0) < datetime.now().replace(tzinfo=PST).time() < time(19,0,0):
		notification_time = 'AM'
	else:
		notification_time = 'PM'

	sns_parameter_store_key = '/CI/MS/' + alarm_env + '/Platform/SNS/' + notification_level + 'NotificationList'+ notification_time

	print('Retrieving SNS Parameter Store key: '+ sns_parameter_store_key)
	ssm_sns = boto3.client('ssm', region_name='us-west-2')
  	
	response = ssm_sns.get_parameters(
		Names=[sns_parameter_store_key], WithDecryption=True
	)

	phone_list = response['Parameters'][0]['Value']
	
	sns = boto3.client('sns', region_name='us-west-2')
	
	print('I will send phones to: '+phone_list)
	
	
	text_body_template="""[{}] {} Microservice AWS Alarm

Alarm Name: {}
Alarm Description: {}
Alarm Time: {}
		    """
	text_body = text_body_template.format(alarm_level.capitalize(),alarm_env.capitalize(),alarm_name,alarm_desc,alarm_time)
	
	phones = phone_list.split(',')

	for phone in phones:
		# Try to send SNS Messages.
		try:
		    #Provide the contents of the email.
		    response = sns.publish(
			    PhoneNumber=phone,
			    Message=text_body,
			    Subject=alarm_env.capitalize()+' Microservice Alarm',
			    MessageStructure='string'
			)
		# Display an error if something goes wrong.	
		except Error as e:
		    print(e.response['Error']['Message'])
		else:
		    print("SMS Messages sent! Message ID:"),
		    print(response['MessageId'])


def actions():
	print('Additional Actions are Currently not Configured')