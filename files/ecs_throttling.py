import os
import json
import boto3
from boto3.dynamodb.conditions import Key, Attr
import time
from datetime import datetime, timedelta
from decimal import Decimal

def lambda_handler(event, context):
    id_name = ""
    new_record = {}
    new_notify_record = {}
    table_name = ""
    notify_table_name = ""

    
    #Variable Configuration for Task Failure Throttling
    CLEANUP_TIME_DAYS = int(os.getenv('CLEANUP_TIME_DAYS', 14))
    MAX_FAIL_THRESH = int(os.getenv('MAX_FAIL_THRESH', 6))
    MAX_FAIL_TIME_MINS = int(os.getenv('MAX_FAIL_TIME_MINS', 15))
    ENV_NAME = os.getenv('ENV_NAME', 'nonprod')
    ECS_TASK_STATE_CHANGE_TABLE = "ci-ECSTaskFailureTracking-" + ENV_NAME
    ECS_TASK_STATE_CHANGE_NOTIFY_TABLE = "ci-ECSTaskFailureNotificationTracking-" + ENV_NAME
    FAILURE_THROTTLING_SNS = os.getenv('FAIL_SNS_TOPIC','NO_SNS')
    FAILURE_THROTTLING_NOTIFY_TIMEOUT_MINS = int(os.getenv('FAILURE_THROTTLING_NOTIFY_TIMEOUT_MINS', 5))
    FAILURE_THROTTLING_SPARK_ROOM = os.getenv('FAILURE_THROTTLING_SPARK_ROOM','NO_SPARK_ROOM')
    FAILURE_THROTTLING_SPARK_ROOM_DETAILS = os.getenv('FAILURE_THROTTLING_SPARK_ROOM_DETAILS','NO_SPARK_ROOM')
    FAILURE_THROTTLING_SPARK_BOT = os.getenv('FAILURE_THROTTLING_SPARK_BOT','NO_SPARK_BOT')
    approved_clusters = ['ci-dev-cluster','ci-test-cluster','ci-test-ft-cluster','ci-qa-cluster','ci-prod-cluster']
    
    curr_time = datetime.utcnow()
    curr_time_formatted = curr_time.isoformat()
    
    #Set Expiration Thresholds for Events and Notifications
    event_expiration_time = curr_time + timedelta(days = CLEANUP_TIME_DAYS)
    notification_expiration_time = curr_time + timedelta(days = CLEANUP_TIME_DAYS*3)
    event_expiration_time = (event_expiration_time - datetime(1970,1,1)).total_seconds()
    notification_expiration_time = (notification_expiration_time - datetime(1970,1,1)).total_seconds()
    
    #For debugging so you can see raw event format.
    print('Here is the event:')
    print(json.dumps(event))

    if event["source"] != "aws.ecs":
       raise ValueError("Function only supports input from events with a source type of: aws.ecs")

    #Filter for Only Task State Changes
    if event["detail-type"] == "ECS Task State Change":
        table_name = ECS_TASK_STATE_CHANGE_TABLE
        notify_table_name = ECS_TASK_STATE_CHANGE_NOTIFY_TABLE
        id_name = "taskArn"
        event_id = event["detail"][id_name]
        cluster_arn = event["detail"]["clusterArn"]
        cluster_name = cluster_arn.split("cluster/",1)[1]
        service_group = event["detail"]["group"]
        service_name = service_group.split(":")[-1]
    else:
        raise ValueError("detail-type for event is not a supported type. Currently Only 'ECS Task State Change' events are accepted. Exiting without saving event.")

    if 'exitCode' in event["detail"]["containers"][0]:
        if event["detail"]["containers"][0]["exitCode"] == 0:
            if str(event["detail"]["stoppedReason"]).startswith("Task failed ELB health checks"):
                print("Task is failing ELB Health Checks")
                new_record["failType"] = "ELB Health Check Failure"
            else:
                print("Task exited sucessfully with Exit Code 0.  Exiting without saving event.")
                return 0
        else:
            print("Task exited with Exit Code " + str(event["detail"]["containers"][0]["exitCode"]))
            new_record["failType"] = "Non-Zero Exit Code"
    else:
        if 'reason' in event["detail"]["containers"][0]:
            new_record["failType"] = event["detail"]["containers"][0]["reason"].split("):",1)[0]
            print("Container is not starting sucessfully due to "+ new_record["failType"])

            print("Sending Throttling Spark Message (Debug Room).  As Amazon throttling occurs, a message will be sent on each failure.")
            os.system("curl https://api.ciscospark.com/v1/messages -X POST -H \"Authorization:Bearer " + FAILURE_THROTTLING_SPARK_BOT + "\" \
                --data \"roomId=" + FAILURE_THROTTLING_SPARK_ROOM_DETAILS + "\" \
                --data \"text=**The '" + service_name + "' service is down in '"+cluster_name+"'.**\n\nThe following microservice has fallen into a pattern of failures and should be addressed immediately:\n \
                Service: " + service_name + "\n \
                Cluster: " + cluster_name + "\n \
                Task Definition: " + event["detail"]["taskDefinitionArn"] + "\n \
                Failures: SERVICE FAILED TO START (No Count)\n \
                Failure Type: " + new_record["failType"] + "\n \
                Failure Threshold: N/A\n \
                Most Recently Failed Task: " + event_id + "\n \
        Please look into application logs, Parameter Store values, and AWS logs in order to resolve this issue as soon as possible! This failure type is throttled by Amazon, and you will receive a notification on each failure.\n ~Pax\" \
                --data \"markdown=**The *'" + service_name + "'* service is down in *'"+cluster_name+"'*\.**\n\nThe following microservice has fallen into a pattern of failures and should be addressed immediately:\n \
    Service: " + service_name + "\n \
    Cluster: " + cluster_name + "\n \
    Task Definition: " + event["detail"]["taskDefinitionArn"] + "\n \
    Failures: SERVICE FAILED TO START (No Count)\n \
    Failure Type: " + new_record["failType"] + "\n \
    Failure Threshold: N/A\n \
    Most Recently Failed Task: " + event_id + "\n \
Please look into application logs, Parameter Store values, and AWS logs in order to resolve this issue as soon as possible\!  This failure type is throttled by Amazon, and you will receive a notification on each failure.  \n\n \
~Pax\"")
        else:
            print("ERROR: Event has neither Exit Code nore expected Error Phrase.  Exiting Lambda")
            return 1


    new_record[id_name] = event_id
    new_record["clusterName"] = cluster_name
    new_record["microService"] = service_name
    new_record["startedAt"] = event["detail"]["createdAt"]
    new_record["stoppedAt"] = event["detail"]["stoppedAt"]
    new_record["stoppedReason"] = event["detail"]["stoppedReason"]
    new_record["taskDefinitionArn"] = event["detail"]["taskDefinitionArn"]
    new_record["version"] = event["detail"]["version"]
    new_record["expiration_time"] = Decimal(event_expiration_time)


    # Cloudwatch events will send each event "at least once"; we must validate 
    # if event has been received. If the version is OLDER than what you have on file, do not process it.
    # Otherwise, update the associated record with this latest information.
    print("Looking for recent event with same ID...")

    dynamodb = boto3.resource("dynamodb", region_name="us-west-2")
    table = dynamodb.Table(table_name)
    saved_event = table.get_item(
        Key={
            id_name : event_id
        }
    )
    if "Item" in saved_event:
        # Compare events and reconcile.
        print("EXISTING EVENT DETECTED: Id " + event_id + " - reconciling")
        if saved_event["Item"]["version"] < event["detail"]["version"]:
            print("Received event is more recent version than stored event - updating")
            table.put_item(
                Item=new_record
            )
        else:
            print("Stored event is more recent version than received event - ignoring")
            return 0
    else:
        print("Saving new event - ID " + event_id)

        table.put_item(
            Item=new_record
        )
   
    # Check count of events for the triggering service, based on the number of 
    # unhealthy container failures (MAX_FAIL_THRESH) and time range (MAX_FAIL_TIME_MINS).
    # If failure, send notification to Spark 

    fail_thresh_time = curr_time - timedelta(minutes = MAX_FAIL_TIME_MINS)
    fail_thresh_time = fail_thresh_time.isoformat()
    
    failure_events_resp = table.scan(
        FilterExpression = Attr("microService").eq(new_record["microService"])  & 
        Attr("clusterName").eq(new_record["clusterName"]) & 
        Attr("taskDefinitionArn").eq(new_record["taskDefinitionArn"]) & 
        Attr("failType").eq(new_record["failType"]) & 
        Attr("stoppedAt").gt(fail_thresh_time)
    )

    failure_events = failure_events_resp['Items']

    #Check to see if entire table was scanned for failures
    #DynamoDB SCAN will only read up to 1MB of data, if more exists, we must paginate as below
    fail_page_count = 0
    while 'LastEvaluatedKey' in failure_events_resp:
        failure_events_resp = table.scan(
            FilterExpression = Attr("microService").eq(new_record["microService"])  & 
            Attr("clusterName").eq(new_record["clusterName"]) & 
            Attr("taskDefinitionArn").eq(new_record["taskDefinitionArn"]) & 
            Attr("failType").eq(new_record["failType"]) & 
            Attr("stoppedAt").gt(fail_thresh_time), ExclusiveStartKey=response['LastEvaluatedKey']
        )
        failure_events.extend(failure_events_resp['Items'])
        fail_page_count = fail_page_count + 1
    print("Pagination was required " + str(fail_page_count) + " times in order to read all DynamoDB Failure Data.")



    
    fail_count = len(failure_events)
    print ("This many Failures: " + str(len(failure_events)))
    print("Service '" + service_name + "' on cluster '" + cluster_name + "' has failed " + str(fail_count) + " times within the past " + str(MAX_FAIL_TIME_MINS) + " minutes.")
    
    ssm = boto3.client('ssm', region_name='us-west-2')

    response = ssm.get_parameters(
        Names=["/CI/MS/" + ENV_NAME + "/SNS/PlatformNotificationList"], WithDecryption=True
    )
    
    numbers = response['Parameters'][0]['Value']

    if ( len(failure_events) > MAX_FAIL_THRESH ):
                
        notify_table = dynamodb.Table(notify_table_name)
        notify_wait_time = curr_time - timedelta(minutes = FAILURE_THROTTLING_NOTIFY_TIMEOUT_MINS)
        notify_wait_time = notify_wait_time.isoformat()
        
        notify_results_resp = notify_table.get_item(
            Key={
                'Service' : service_name,
                'ClusterName' : cluster_name
            }
        )
        
        notify_results={}
        notify_expired = 0
        
        if "Item" in notify_results_resp:
            notify_results = notify_results_resp['Item']
            if(notify_results['LastNotification']<notify_wait_time):
                notify_expired = 1

        print("Notify Expired: " + str(notify_expired))
        
        #Determines whether Notification is Required
        if ( ( len(notify_results)==0 ) or ( notify_expired==1  ) ):
            new_notify_record["Service"] = service_name
            new_notify_record["ClusterName"] = cluster_name
            new_notify_record["LastNotification"] = curr_time_formatted
            new_notify_record["NumFailures"] = fail_count
            new_notify_record["FailThreshold"] = MAX_FAIL_THRESH
            new_notify_record["FailTimeout"] = MAX_FAIL_TIME_MINS
            new_notify_record["FailType"] = new_record["failType"]
            new_notify_record["expiration_time"] = Decimal(notification_expiration_time)
            
            notify_table.put_item(
                Item=new_notify_record
            )

            #Communicating Failure to General Public based on white-listed clusters
            print("Checking Cluster Name to determine if messaging is allowed")
            

            if( cluster_name in approved_clusters ):
                print("Sending Throttling Spark Message (General Public)")
                
                os.system("curl https://api.ciscospark.com/v1/messages -X POST -H \"Authorization:Bearer " + FAILURE_THROTTLING_SPARK_BOT + "\" \
                --data \"roomId=" + FAILURE_THROTTLING_SPARK_ROOM + "\" \
                --data \"text=**The '" + service_name + "' service is down in '"+cluster_name+"'.**\n~Pax\" \
                --data \"markdown=**The *'" + service_name + "'* service is down in *'"+cluster_name+"'*\.**\n~Pax\"")

                print("Sending Throttling SMS message to Phone Numbers from Parameter Store")
                sns = boto3.client('sns')
        
                sns.publish(
            ## TopicArn=FAILURE_THROTTLING_SNS,
                PhoneNumber = numbers,
                Message='The following microservice has fallen into a pattern of failures and should be addressed immediately:\n \
                Service: ' + service_name + '\n \
                Cluster: ' + cluster_name + '\n \
                Task Definition: ' + new_record["taskDefinitionArn"] + '\n \
                Failures: ' + str(fail_count) + '\n \
                Failure Threshold: ' + str(MAX_FAIL_THRESH) + '\n \
Please address this issue as soon as possible!',
                Subject="Throtting Occurring for '" + service_name + "' on cluster '" + cluster_name +"'"
                )
            else:
                print("Cluster "+ str(cluster_name)+ " is currently not approved for communication to the General Public.")

            #Communicating Failure to Debugging Channel for all clusters (no white-list filter)
            print("Sending Throttling Spark Message (Debug Room)")
            os.system("curl https://api.ciscospark.com/v1/messages -X POST -H \"Authorization:Bearer " + FAILURE_THROTTLING_SPARK_BOT + "\" \
                --data \"roomId=" + FAILURE_THROTTLING_SPARK_ROOM_DETAILS + "\" \
                --data \"text=**The '" + service_name + "' service is down in '"+cluster_name+"'.**\n\nThe following microservice has fallen into a pattern of failures and should be addressed immediately:\n \
                Service: " + service_name + "\n \
                Cluster: " + cluster_name + "\n \
                Task Definition: " + new_record["taskDefinitionArn"] + "\n \
                Failures: " + str(fail_count) + "\n \
                Failure Type: " + new_record["failType"] + "\n \
                Failure Threshold: " + str(MAX_FAIL_THRESH) + "\n \
                Most Recently Failed Task: " + event_id + "\n \
        Please look into application logs, Parameter Store values, and AWS logs in order to resolve this issue as soon as possible! \n ~Pax\" \
                --data \"markdown=**The *'" + service_name + "'* service is down in *'"+cluster_name+"'*\.**\n\nThe following microservice has fallen into a pattern of failures and should be addressed immediately:\n \
    Service: " + service_name + "\n \
    Cluster: " + cluster_name + "\n \
    Task Definition: " + new_record["taskDefinitionArn"] + "\n \
    Failures: " + str(fail_count) + "\n \
    Failure Type: " + new_record["failType"] + "\n \
    Failure Threshold: " + str(MAX_FAIL_THRESH) + "\n \
    Most Recently Failed Task: " + event_id + "\n \
Please look into application logs, Parameter Store values, and AWS logs in order to resolve this issue as soon as possible\!  \n\n \
~Pax\"")
        else:
            print("Skipping notification, as notification has occured in the past " + str(FAILURE_THROTTLING_NOTIFY_TIMEOUT_MINS) + " minutes.")
    else:
        print("No Throttling Occurred.")
