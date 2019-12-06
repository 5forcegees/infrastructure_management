/* ==== **IMPORTANT** - Review the values within each resource (i.e. parameter) to ensure that the value is accurate. */
/* Failure to do so will result in the microservices pointing to the incorrect parameter */
/* Environment: prod */
## params not managed in terraform due to their protected values
## (username/passwords) ## these should be managed directly in the console by authorized users
#resource "aws_ssm_parameter" "CloudfrontAPIGateway-TokenKey"  {
#    name = "/CI/MS/<environment>/CloudfrontAPIGateway/TokenKey"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "CloudfrontAPIGateway-TokenValue"  {
#    name = "/CI/MS/<environment>/CloudfrontAPIGateway/TokenValue"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "CloudfrontAPIGateway-ThirdPartyTokenKey"  {
#    name = "/CI/MS/<environment>/CloudfrontAPIGateway/ThirdPartyTokenKey"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "CloudfrontAPIGateway-ThirdPartyTokenValue"  {
#    name = "/CI/MS/<environment>/CloudfrontAPIGateway/ThirdPartyTokenValue"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "CassandraSettings-ClusterUser"  {
#    name = "/CI/MS/<environment>/CassandraSettings/ClusterUser"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "CassandraSettings-ClusterPassword"  {
#    name = "/CI/MS/<environment>/CassandraSettings/ClusterPassword"
#    type = "SecureString"
#
#**************************************************************************************
# MCF User Credentials
#**************************************************************************************
#resource "aws_ssm_parameter" "MCF-OutageUserPassword"  {
#    name = "/CI/MS/<environment>/MCF/OutageUserPassword"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "MCF-UserCreationPassword"  {
#    name = "/CI/MS/<environment>/MCF/UserCreationServiceUserPassword"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "MCF-CustomerPassword"  {
#    name = "/CI/MS/<environment>/MCF/CustomerUserPassword"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "MB-ClientId"  {
#    name = "/CI/MS/<environment>/MB/ClientId"
#    type = "SecureString"
#    value= ""
#    description = "MessageBroadcast API clientId"
#}
#resource "aws_ssm_parameter" "MB-ClientApiToken"  {
#    name = "/CI/MS/<environment>/MB/ClientApiToken"
#    type = "SecureString"
#    value= ""
#    description = "MessageBroadcast API client API token"
#}
#resource "aws_ssm_parameter" "Document-Encryption-Key" {
#  name        =  "/CI/MS/<environment>/Document/Fiserv-AccountStatementPassword"
#  type        = "SecureString"
#  description = "Document repo encryption key value."
#}
#resource "aws_ssm_parameter" "Document-Encryption-Salt" {
#  name        =  "/CI/MS/<environment>/Document/Fiserv-AccountStatementSalt"
#  type        = "SecureString"
#  description = "Document repo encryption salt value."
#}
#resource "aws_ssm_parameter" "Outage-Api-Key" {
#  name        =  "/CI/MS/<environment>/OutageServicesApi/x_api_key"
#  type        = "SecureString"
#  description = "Outage Services key."
#}
#resource "aws_ssm_parameter" "Splunk-HEC-Token" {
#  name        =  "/CI/MS/<environment>/Platform/Splunk/HEC_Token"
#  type        = "SecureString"
#  description = "HEC Token used for Splunk Connectivity"
#}
#resource "aws_ssm_parameter" "Splunk-HEC-URL" {
#  name        =  "/CI/MS/<environment>/Platform/Splunk/HEC_URL"
#  type        = "SecureString"
#  description = "HEC URL used for Splunk Connectivity"
#}
#resource "aws_ssm_parameter" "SNS-General-Notification-List" {
#  name        =  "/CI/MS/<environment>/SNS/GeneralNotificationList"
#  type        = "SecureString"
#  description = "SMS Notification List for General Notifications"
#}
#resource "aws_ssm_parameter" "SNS-Platform-Notification-List" {
#  name        =  "/CI/MS/<environment>/SNS/PlatformNotificationList"
#  type        = "SecureString"
#  description = "SMS Notification List for Platform Notifications"
#}
#resource "aws_ssm_parameter" "SNS-NOC-Notification-List" {
#  name        =  "/CI/MS/<environment>/SNS/NOCNotificationList"
#  type        = "SecureString"
#  description = "SMS Notification List for NOC Notifications"
#}
#resource "aws_ssm_parameter" "Mcf-CustomerUserName"  {
#  name = "/CI/MS/prod/MCF/CustomerUserName"
#  type = "String"
#  value= "UMC_ANM_SRV"
#  description = ""
#  tags = "${var.default_tags}"
#}
#resource "aws_ssm_parameter" "Mcf-Landlord-UserName"  {
#  name = "/CI/MS/prod/MCF/Landlord/UserName"
#  type = "String"
#  value= "UMC_LRD_SRV"
#  description = ""
#  tags = "${var.default_tags}"
#}
#resource "aws_ssm_parameter" "Mcf-OutageUserName"  {
# name = "/CI/MS/prod/MCF/OutageUserName"
#  type = "String"
#  value= "UMC_ANM_SRV"
#  description = ""
#  tags = "${var.default_tags}"
#}
#resource "aws_ssm_parameter" "Mcf-UserCreationServiceUser"  {
#  name = "/CI/MS/prod/MCF/UserCreationServiceUser"
# type = "String"
#  value= "UMC_SRV_USR"
#  description = ""
#  tags = "${var.default_tags}"
#}

## params managed by terraform, these should only be updated/created/destroyed in terraform, not the console

resource "aws_ssm_parameter" "BillMatrix-CliendID" {
  name        = "/CI/MS/prod/BillMatrix/CliendID"
  type        = "String"
  value       = "1629"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-PaymentChannel_Fee" {
  name        = "/CI/MS/prod/BillMatrix/PaymentChannel_Fee"
  type        = "String"
  value       = "I|L001629"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-PaymentChannel_NoFee" {
  name        = "/CI/MS/prod/BillMatrix/PaymentChannel_NoFee"
  type        = "String"
  value       = "I|K001629"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-PaymentChannel_Registered_Fee" {
  name        = "/CI/MS/prod/BillMatrix/PaymentChannel_Registered_Fee"
  type        = "String"
  value       = "I|J001629"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-PaymentChannel_Registered_NoFee" {
  name        = "/CI/MS/prod/BillMatrix/PaymentChannel_Registered_NoFee"
  type        = "String"
  value       = "I|I001629"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-Url" {
  name        = "/CI/MS/prod/BillMatrix/Url"
  type        = "String"
  value       = "https://www.paybill.com/consumer/account/FormPostLogIn?clientid=client_GUEST"
  description = "Base URL for BillMatrix payments"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BucketName-Correspondence" {
  name        = "/CI/MS/prod/Document/BucketName/Correspondence"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.s3_BucketName_Correspondence}"
  description = "S3 bucket for correspondence documents"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BucketName-Statements" {
  name        = "/CI/MS/prod/Document/BucketName/Statements"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.s3_BucketName_Statements}"
  description = "S3 bucket for account statement documents"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BudgetBilling-MonthsBackValue" {
  name        = "/CI/MS/prod/BILLINGHISTORY/MONTHSBACK"
  type        = "String"
  value       = "24"
  description = "parameter for storing number of months back to look for budget billing history"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-ConsistencyLevel" {
  name        = "/CI/MS/prod/CassandraSettings/ConsistencyLevel"
  type        = "String"
  value       = "LocalQuorum"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-Hosts" {
  name        = "/CI/MS/prod/CassandraSettings/Hosts"
  type        = "String"
  value       = "[{\"HostName\":\"node1.dse.clientpublic.loc\",\"IpAddress\":\"10.128.106.215\"},{\"HostName\":\"node2.dse.clientpublic.loc\",\"IpAddress\":\"10.128.109.242\"},{\"HostName\":\"node3.dse.clientpublic.loc\",\"IpAddress\":\"10.128.111.47\"}]"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-MaxConnectionsFromHost" {
  name        = "/CI/MS/prod/CassandraSettings/MaxConnectionsFromHost"
  type        = "String"
  value       = "500"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-Port" {
  name        = "/CI/MS/prod/CassandraSettings/Port"
  type        = "String"
  value       = "9042"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-UseClusterCredentials" {
  name        = "/CI/MS/prod/CassandraSettings/UseClusterCredentials"
  type        = "String"
  value       = "true"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-UseQueryOptions" {
  name        = "/CI/MS/prod/CassandraSettings/UseQueryOptions"
  type        = "String"
  value       = "true"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-UseSSL" {
  name        = "/CI/MS/prod/CassandraSettings/UseSSL"
  type        = "String"
  value       = "true"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Shared-CassandraKeyspace-Microservices" {
  name        = "/CI/MS/prod/Cassandra/Keyspace/Microservices"
  type        = "String"
  value       = "selfservice"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Shared-CassandraKeyspace-SelfServiceAuth" {
  name        = "/CI/MS/prod/Cassandra/Keyspace/SelfServiceAuth"
  type        = "String"
  value       = "selfservice_auth"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "RegionEndpoint" {
  name        = "/CI/MS/prod/RegionEndpoint"
  type        = "String"
  value       = "us-west-2"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Cognito-UserPool" {
  name        = "/CI/MS/prod/Cognito/UserPool"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.cognito_user_pool_id}"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "PROD_ALB_URL" {
  name        = "/CI/MS/prod/ALB_URL"
  type        = "String"
  value       = "http://selfservice-prod-alb.client.com"
  description = "Microservices Load Balancer URL"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "DQM-EndPointAddress" {
  name        = "/CI/MS/prod/DQM/EndPointAddress"
  type        = "String"
  value       = "https://ssapbdprda.url.client.com:8005/DataServices/servlet/webservices?ver=2.0"
  description = "DQM Address Validation endpoint"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Renewable-ServiceUrl" {
  name        = "/CI/MS/prod/Forms/Renewable/ServiceUrl"
  type        = "String"
  value       = "https://internalservices.clientpublic.loc/customer/BillAnalysis/Service.svc"
  description = "URL to sign up for renewables / green power etc."
  tags = "${var.default_tags}"
}


resource "aws_ssm_parameter" "LEGACY_client-URL" {
  name        = "/CI/MS/prod/LEGACY_client/URL"
  type        = "String"
  value       = "https://sharedservices.url.client.com"
  description = "Legacy Interface Web Services"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "client-Not-Out" {
  name        = "/CI/MS/prod/client/Not-Out/URL"
  type        = "String"
  value       = "http://${data.terraform_remote_state.infrastructure.third_party_alb_dns}"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "MCF-HOST" {
  name        = "/CI/MS/prod/MCF/HOST"
  type        = "String"
  value       = "ssappn1prdav.url.client.com"
  description = "PN1/100"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "MCF-SSL_PORT" {
  name        = "/CI/MS/prod/MCF/SSL_PORT"
  type        = "String"
  value       = "8005"
  description = "Port for secure SAP MCF requests"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Redis-URL" {
  name        = "/CI/MS/prod/Redis/URL"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.redis_primary_endpoint_address},resolvedns=1,abortConnect=false"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "PasswordReset-MaxAttemptsPerChallenge" {
  name        = "/CI/MS/prod/Authentication/PasswordReset/MaxAttemptsPerChallenge"
  type        = "String"
  value       = "3"
  description = "Number of times a user is allowed to answer each security question incorrectly"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "PasswordReset-MaxChallenges" {
  name        = "/CI/MS/prod/Authentication/PasswordReset/MaxChallenges"
  type        = "String"
  value       = "2"
  description = "Maximum number of security questions to ask at one time"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "SecurityQuestions-PasswordResetTimespanMinutes" {
  name        = "/CI/MS/prod/Authentication/PasswordReset/TokenLifespanMinutes"
  type        = "String"
  value       = "1440"
  description = "How long to keep a password reset token in the cache"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "SecurityQuestions-PasswordResetLockMinutes" {
  name        = "/CI/MS/prod/Authentication/PasswordReset/LockMinutes"
  type        = "String"
  value       = "1440"
  description = "How long to keep a user locked after initiating a password reset"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "authentication-mcf-gateway" {
  name        = "/CI/MS/prod/Authentication/Mcf/Gateway"
  type        = "String"
  value       = "MCF_PRD_Gateway"
  description = "Used by SAML identity provider in authentication repo"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "SecurityQuestions-MaximumSet" {
  name        = "/CI/MS/prod/Authentication/SecurityQuestions/MaximumSet"
  type        = "String"
  value       = "4"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "SecurityQuestions-MinimumSet" {
  name        = "/CI/MS/prod/Authentication/SecurityQuestions/MinimumSet"
  type        = "String"
  value       = "4"
  description = "Minimum number of security questions required"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-LockUser-IncorrectPasswordRetentionMinutes" {
  name        = "/CI/MS/prod/Authentication/LockUser/IncorrectPasswordRetentionMinutes"
  type        = "String"
  value       = "15"
  description = "How many minutes to remember an incorrect password attempt"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-LockUser-IncorrectPasswordLockMinutes" {
  name        = "/CI/MS/prod/Authentication/LockUser/IncorrectPasswordLockMinutes"
  type        = "String"
  value       = "15"
  description = "How many minutes to keep the user locked after max incorrect password attempts"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-LockUser-IncorrectPasswordMaxAttempts" {
  name        = "/CI/MS/prod/Authentication/LockUser/IncorrectPasswordMaxAttempts"
  type        = "String"
  value       = "5"
  description = "Maximum incorrect password attempts before locking out user"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-Cognito-ClientId" {
  name        = "/CI/MS/prod/Authentication/Cognito/ClientId"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.cognito_user_pool_client_id}"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-Cognito-ImpersonationClientId" {
  name        = "/CI/MS/prod/Authentication/Cognito/ImpersonationClientId"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.cognito_user_pool_client_impersonation_id}"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-ResetPassword-SiteCorePasswordResetUrlBase" {
  name        = "/CI/MS/prod/Authentication/PasswordReset/SiteCorePasswordResetUrlBase"
  type        = "String"
  value       = "https://www.client.com/reset-password?token="
  description = "Sitecore password reset url base"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-OutageSession-SessionExpirationInMinutes" {
  name        = "/CI/MS/prod/Authentication/OutageSession/SessionExpirationInMinutes"
  type        = "String"
  value       = "120"
  description = "How long an anonyous session lasts. Used in OutageSessionLogic. We think this was 2 minutes and got bumped up to 2 hours for testing"
  tags = "${var.default_tags}"
}

#TODO: Verifiy Email Address
resource "aws_ssm_parameter" "Outage-Queue-ExceptionInbox" {
  name        = "/CI/MS/prod/Outage/Queue/ExceptionInbox"
  type        = "String"
  value       = "SystemOpsCutover@client.com"
  description = "exception inbox for outage queues"
  tags = "${var.default_tags}"		
}		
			
resource "aws_ssm_parameter" "Outage-Queue-Default-RateLimit" {		
  name        = "/CI/MS/prod/Outage/Queue/Default/RateLimit"		
  type        = "String"		
  value       = "10"		
  description = "How many milliseconds to wait between processing each queue message"
  tags = "${var.default_tags}"
}		

resource "aws_ssm_parameter" "Outage-Queue-ReportOutage-Namespace" {		
  name        = "/CI/MS/prod/Outage/Queue/Mcf/ReportOutage"		
  type        = "String"		
  value       = "${data.terraform_remote_state.infrastructure.sqs_outage_reportoutage}"		
  description = "Outage report outage queue namespace"
  tags = "${var.default_tags}"		
}

resource "aws_ssm_parameter" "Document-MonthlyInsertURL" {
  name        = "/CI/MS/prod/Document/MonthlyInsertURL"
  type        = "String"
  value       = "https://www.client.com/-/media/bill-inserts/"
  description = "Url prefix for monthly bill insert pdf"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Document-DocumentHistoryBaseURL" {
  name        = "/CI/MS/prod/Document/DocumentHistoryBaseURL"
  type        = "String"
  value       = "/sap/opu/odata/sap/ZERP_UTILITIES_UMC_client_SRV/CorrespondenceDatas"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Notification-PreferenceUpdate-SNSTopicARN" {
  name        = "/CI/MS/prod/Notification/PreferenceUpdate/SNSTopicARN"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sns_notification_preference_update}"
  description = "SNS Topic to publish the Notification Preference Update event message to"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Notification-SendNotification-SNSTopicARN" {
  name        = "/CI/MS/prod/Notification/SendNotification/SNSTopicARN"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sns_notification_send_notification}"
  description = "SNS Topic to publish the Send Notification event message to"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CommGateway-ServiceRelay-SNSTopicARN" {
  name        = "/CI/MS/prod/CommGateway/ServiceRelay-SNSTopicARN"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sns_commgateway_servicerelay}"
  description = "SNS Topic to publish the Service Relay event message to"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "MB-ApiEndpoint" {
  name        = "/CI/MS/prod/MB/ApiEndpoint"
  type        = "String"
  value       = "https://client.messagebroadcast.com/v1"
  description = "Message Broadcast API endpoint"
  tags = "${var.default_tags}"
}

#Commgateway-prefUp-sap
resource "aws_ssm_parameter" "Commgateway-PrefUp-SAP-AWSSQSQueueUrl" {	
  name        = "/CI/MS/prod/CommGateway/prefUp-sap-SQS"
  type        = "String"		
  value       = "${data.terraform_remote_state.infrastructure.sqs_commgateway_prefUp_sap}"		
  description = "AWS SQS Queue name for Commgateway PrefUp SAP"	
  tags = "${var.default_tags}"	
}		

#Commgateway-prefUp-mb		
resource "aws_ssm_parameter" "Commgateway-PrefUp-MB-AWSSQSQueueUrl" {		
  name        = "/CI/MS/prod/CommGateway/prefUp-mb-SQS"		
  type        = "String"		
  value       = "${data.terraform_remote_state.infrastructure.sqs_commgateway_prefUp_mb}"		
  description = "AWS SQS Queue name for Commgateway PrefUp MB"	
  tags = "${var.default_tags}"	
}		

#Commgateway-service-relay		
resource "aws_ssm_parameter" "Commgateway-Service-Relay-AWSSQSQueueUrl" {		
  name        = "/CI/MS/prod/CommGateway/service-relay-SQS"		
  type        = "String"		
  value       = "${data.terraform_remote_state.infrastructure.sqs_commgateway_service_relay}"		
  description = "AWS SQS Queue name for Commgateway Service Relay"	
  tags = "${var.default_tags}"	
}		
			
#Commgateway-message-intercept		
resource "aws_ssm_parameter" "Commgateway-Message-Intercept-AWSSQSQueueUrl" {		
  name        = "/CI/MS/prod/CommGateway/message-intercept-SQS"		
  type        = "String"		
  value       = "${data.terraform_remote_state.infrastructure.sqs_commgateway_message_intercept}"		
  description = "AWS SQS Queue name for Commgateway Message Intercept"
  tags = "${var.default_tags}"		
}

#Begin AWSSQS Queues for MicroServices

#Account
resource "aws_ssm_parameter" "Account-AWSSQSQueueUrl" {
  name        = "/CI/MS/prod/Account/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_account}"
  description = "AWS SQS Queue name for Account microservice"
  tags = "${var.default_tags}"
}

#Customer
resource "aws_ssm_parameter" "Customer-AWSSQSQueueUrl" {
  name        = "/CI/MS/prod/Customer/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_customer}"
  description = "AWS SQS Queue name for Customer microservice"
  tags = "${var.default_tags}"
}

#Device
resource "aws_ssm_parameter" "Device-AWSSQSQueueUrl" {
  name        = "/CI/MS/prod/Device/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_device}"
  description = "AWS SQS Queue name for Device microservice"
  tags = "${var.default_tags}"
}

#Payment
resource "aws_ssm_parameter" "Payment-AWSSQSQueueUrl" {
  name        = "/CI/MS/prod/Payment/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_payment}"
  description = "AWS SQS Queue name for Payment microservice"
  tags = "${var.default_tags}"
}

#Statement
resource "aws_ssm_parameter" "Statement-AWSSQSQueueUrl" {
  name        = "/CI/MS/prod/Statement/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_statement}"
  description = "AWS SQS Queue name for Statement microservice"
  tags = "${var.default_tags}"
}

#Budget Bill
resource "aws_ssm_parameter" "BudgetBill-AWSSQSQueueUrl" {
  name        = "/CI/MS/prod/BudgetBill/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_budgetbill}"
  description = "AWS SQS Queue name for BudgetBill microservice"
  tags = "${var.default_tags}"
}

#End AWSSQS Queues for MicroServices

#TODO: Review
#TODO: Validate Cert on the legacy service
#Getting token from legacy service to redirect to O Power (energy uses)
resource "aws_ssm_parameter" "Authentication-LEGACY_client-SamlTokenUrl" {
  name        = "/CI/MS/prod/Authentication/LEGACY_client/SamlTokenUrl"
  type        = "String"
  value       = "https://internalservices.clientpublic.loc/SamlGenerator/OpowerSaml.svc"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-Logging-MinimumLevel" {		
  name        = "/CI/MS/prod/Authentication/Logging/MinimumLevel"		
  type        = "String"		
  value       = "Information"		
  description = ""	
  tags = "${var.default_tags}"	
}
resource "aws_ssm_parameter" "Document-Logging-MinimumLevel" {
  name        = " /CI/MS/prod/document/Logging/MinimumLevel"
  type        = "String"
  value       = "Information"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Outage-Logging-MinimumLevel" {
  name        = " /CI/MS/prod/outage/Logging/MinimumLevel"
  type        = "String"
  value       = "Information"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Shared-Logging-MinimumLevel" {		
  name        = "/CI/MS/prod/Shared/Logging/MinimumLevel"		
  type        = "String"		
  value       = "Information"		
  description = ""	
  tags = "${var.default_tags}"	
}

resource "aws_ssm_parameter" "Outage-Host" {
  name        = "/CI/MS/prod/OutageServicesApi/Host"
  type        = "String"
  value       = "http://${data.terraform_remote_state.infrastructure.third_party_alb_dns}"
  description = "Host for Outage Services Api"
  tags = "${var.default_tags}"
}

#This parameter not being used in code, but need cleanup in code to remove references from payment repo
#Item for hypercare
resource "aws_ssm_parameter" "LEGACY_client-AnonymousCallsEndpoint" {
  name        = "/CI/MS/prod/LEGACY_client/AnonymousCallsEndpoint"
  type        = "String"
  value       = "https://internalservices.clientpublic.loc/Customer/AnonymousCalls/Service.svc"
  description = ""
  tags = "${var.default_tags}"
}


############################################################
#TODO: Potentially Removeable BELOW
############################################################

resource "aws_ssm_parameter" "Forms-EmailServiceEndPoint" {
  name        = "/CI/MS/prod/Forms/EmailServiceEndPoint"
  type        = "String"
  value       = "https://internalservices.clientpublic.loc/EmailProxy/SendMailProxy.svc"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "EgainPropertyManagerService-FromEmail" {
  name        = "/CI/MS/prod/Forms/EgainPropertyManagerService/FromEmail"
  type        = "String"
  value       = "customercare@client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "EgainPropertyManagerService-Subject" {
  name        = "/CI/MS/prod/Forms/EgainPropertyManagerService/Subject"
  type        = "String"
  value       = "MULTI_FAMILY"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "EgainPropertyManagerService-ToEmail" {
  name        = "/CI/MS/prod/Forms/EgainPropertyManagerService/ToEmail"
  type        = "String"
  value       = "customercare@client.com"
  description = ""
  tags = "${var.default_tags}"
}

#Unsecure MCF may need to be removed
resource "aws_ssm_parameter" "MCF-PORT" {
  name        = "/CI/MS/prod/MCF/PORT"
  type        = "String"
  value       = "8002"
  description = "Port for SAP MCF requests"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Notification-EmailServiceEndPoint" {
  name        = "/CI/MS/prod/Notification/EmailServiceEndPoint"
  type        = "String"
  value       = "https://internalservices.clientpublic.loc/EmailProxy/SendMailProxy.svc"
  description = "Legacy Send Email endpoint"
  tags = "${var.default_tags}"
}


resource "aws_ssm_parameter" "StreetLight-EndPointAddress" {
  name        = "/CI/MS/prod/Forms/StreetLight/EndPointAddress"
  type        = "String"
  value       = "https://internalservices.clientpublic.loc/EmailProxy/SendMailProxy.svc"
  description = "Legacy send email endpoint"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "StreetLight-FromEmail" {
  name        = "/CI/MS/prod/Forms/StreetLight/FromEmail"
  type        = "String"
  value       = "customercare@client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "StreetLight-Subject" {
  name        = "/CI/MS/prod/Forms/StreetLight/Subject"
  type        = "String"
  value       = "STREET_LIGHT_OUTAGE"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "StreetLight-ToEmail" {
  name        = "/CI/MS/prod/Forms/StreetLight/ToEmail"
  type        = "String"
  value       = "customercare@client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-ResetPassword-BusinessCategory" {
  name        = "/CI/MS/prod/Authentication/PasswordReset/BusinessCategory"
  type        = "String"
  value       = "Account_Services"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-ResetPassword-BusinessSubCategory" {
  name        = "/CI/MS/prod/Authentication/PasswordReset/BusinessSubCategory"
  type        = "String"
  value       = "MA-07-001"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Spa-ServiceUrl" {
  name        = "/CI/MS/prod/Project/Spa/ServiceUrl"
  type        = "String"
  value       = "https://sestwebsvc1.url.client.com/SpaService/Service.svc"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "LEGACY_client-NotOutPort" {
  name        = "/CI/MS/prod/LEGACY_client/NotOutPort"
  type        = "String"
  value       = "8081"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "AWSLogTarget-Region" {
  name        = "/CI/MS/prod/AWSLogTarget/Region"
  type        = "String"
  value       = "us-west-2"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "ContractAccountValidator-CacheExpiration" {
  name        = "/CI/MS/prod/ContractAccountValidator/CacheExpiration"
  type        = "String"
  value       = "00:10:00"
  description = ""
  tags = "${var.default_tags}"
}
