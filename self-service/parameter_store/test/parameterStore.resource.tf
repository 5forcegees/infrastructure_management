/* ==== **IMPORTANT** - Review the values within each resource (i.e. parameter) to ensure that the value is accurate. */
/* Failure to do so will result in the microservices pointing to the incorrect parameter */
/* Environment: test */

## params not managed in terraform due to their protected values (username/passwords, etc)
## these should be managed directly in the console by authorized users
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
#resource "aws_ssm_parameter" "Authentication-impersonationAgentAuthSignInKey"  {
#    name = "/CI/MS/<environment>/Authentication/Impersonation/AgentAuthSignInKey"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "Authentication-impersonationAgentAuthIssuer"  {
#    name = "/CI/MS/<environment>/Authentication/Impersonation/AgentAuthIssuer"
#    type = "SecureString"
#**************************************************************************************
# MCF User Credentials
#**************************************************************************************
#resource "aws_ssm_parameter" "MCF-OutageUserName"  {
#    name = "/CI/MS/<environment>/MCF/OutageUserName"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "MCF-OutageUserPassword"  {
#    name = "/CI/MS/<environment>/MCF/OutageUserPassword"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "MCF-UserCreation"  {
#    name = "/CI/MS/<environment>/MCF/UserCreationServiceUser"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "MCF-UserCreationPassword"  {
#    name = "/CI/MS/<environment>/MCF/UserCreationServiceUserPassword"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "MCF-CustomerUserName"  {
#    name = "/CI/MS/<environment>/MCF/CustomerUserName"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "MCF-CustomerPassword"  {
#    name = "/CI/MS/<environment>/MCF/CustomerUserPassword"
#    type = "SecureString"
#
#resource "aws_ssm_parameter" "Mcf-Landlord-Username"  {
#    name = "/CI/MS/<environment>/MCF/Landlord/UserName"
#    type = "String"
#    value= ""
#    description = ""
#}
#resource "aws_ssm_parameter" "Mcf-Landlord-Password"  {
#    name = "/CI/MS/<environment>/MCF/Landlord/Password"
#    type = "String"
#    value= ""
#    description = ""
#}
#resource "aws_ssm_parameter" "MB-ClientId"  {
#    name = "/CI/MS/<environment>/MB/ClientId"
#    type = "String"
#    value= ""
#    description = "MessageBroadcast API clientId"
#}
#resource "aws_ssm_parameter" "MB-ClientApiToken"  {
#    name = "/CI/MS/<environment>/MB/ClientApiToken"
#    type = "String"
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

## params managed by terraform, these should only be updated/created/destroyed in terraform, not the console

resource "aws_ssm_parameter" "AWSLogTarget-LogGroup" {
  name        = "/CI/MS/test/AWSLogTarget/LogGroup"
  type        = "String"
  value       = "test-account-history"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "AWSLogTarget-Region" {
  name        = "/CI/MS/test/AWSLogTarget/Region"
  type        = "String"
  value       = "us-west-2"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-CliendID" {
  name        = "/CI/MS/test/BillMatrix/CliendID"
  type        = "String"
  value       = "1629"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-PaymentChannel_Fee" {
  name        = "/CI/MS/test/BillMatrix/PaymentChannel_Fee"
  type        = "String"
  value       = "I|L001629"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-PaymentChannel_NoFee" {
  name        = "/CI/MS/test/BillMatrix/PaymentChannel_NoFee"
  type        = "String"
  value       = "I|K001629"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-PaymentChannel_Registered_Fee" {
  name        = "/CI/MS/test/BillMatrix/PaymentChannel_Registered_Fee"
  type        = "String"
  value       = "I|J001629"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-PaymentChannel_Registered_NoFee" {
  name        = "/CI/MS/test/BillMatrix/PaymentChannel_Registered_NoFee"
  type        = "String"
  value       = "I|I001629"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-Url" {
  name        = "/CI/MS/test/BillMatrix/Url"
  type        = "String"
  value       = "https://cie.paybill.com/consumer/account/FormPostLogIn?clientid=client_GUEST"
  description = "Base URL for BillMatrix payments"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BucketName-Correspondence" {
  name        = "/CI/MS/test/Document/BucketName/Correspondence"
  type        = "String"
  value       = "clientdevcorrespondence"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BucketName-Statements" {
  name        = "/CI/MS/test/Document/BucketName/Statements"
  type        = "String"
  value       = "clientdevstatements"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BudgetBilling-MonthsBackValue" {
  name        = "/CI/MS/test/BILLINGHISTORY/MONTHSBACK"
  type        = "String"
  value       = "24"
  description = "parameter for storing number of months back to look for budget billing history"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-ConsistencyLevel" {
  name        = "/CI/MS/test/CassandraSettings/ConsistencyLevel"
  type        = "String"
  value       = "LocalQuorum"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-Hosts" {
  name        = "/CI/MS/test/CassandraSettings/Hosts"
  type        = "String"
  value       = "[{\"HostName\":\"10.128.42-204\",\"IpAddress\":\"10.128.42.204\"},{\"HostName\":\"10.128.42-114\",\"IpAddress\":\"10.128.42.114\"},{\"IpAddress\":\"10.128.45.50\"}]"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-MaxConnectionsFromHost" {
  name        = "/CI/MS/test/CassandraSettings/MaxConnectionsFromHost"
  type        = "String"
  value       = "100"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-Port" {
  name        = "/CI/MS/test/CassandraSettings/Port"
  type        = "String"
  value       = "9042"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-UseClusterCredentials" {
  name        = "/CI/MS/test/CassandraSettings/UseClusterCredentials"
  type        = "String"
  value       = "true"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-UseQueryOptions" {
  name        = "/CI/MS/test/CassandraSettings/UseQueryOptions"
  type        = "String"
  value       = "true"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-UseSSL" {
  name        = "/CI/MS/test/CassandraSettings/UseSSL"
  type        = "String"
  value       = "false"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Shared-CassandraKeyspace-Microservices" {
  name        = "/CI/MS/test/Cassandra/Keyspace/Microservices"
  type        = "String"
  value       = "selfservice_qa"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Shared-CassandraKeyspace-SelfServiceAuth" {
  name        = "/CI/MS/test/Cassandra/Keyspace/SelfServiceAuth"
  type        = "String"
  value       = "selfservice_auth"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "RegionEndpoint" {
  name        = "/CI/MS/test/RegionEndpoint"
  type        = "String"
  value       = "us-west-2"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Cognito-UserPool" {
  name        = "/CI/MS/test/Cognito/UserPool"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.cognito_user_pool_id}"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "ContractAccountValidator-CacheExpiration" {
  name        = "/CI/MS/test/ContractAccountValidator/CacheExpiration"
  type        = "String"
  value       = "00:10:00"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "ALB_URL" {
  name        = "/CI/MS/test/ALB_URL"
  type        = "String"
  value       = "http://selfservice-test-alb.client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "DQM-EndPointAddress" {
  name        = "/CI/MS/test/DQM/EndPointAddress"
  type        = "String"
  value       = "https://dqm.client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "EgainPropertyManagerService-FromEmail" {
  name        = "/CI/MS/test/Forms/EgainPropertyManagerService/FromEmail"
  type        = "String"
  value       = "test@client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "EgainPropertyManagerService-Subject" {
  name        = "/CI/MS/test/Forms/EgainPropertyManagerService/Subject"
  type        = "String"
  value       = "Property_Manager"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "EgainPropertyManagerService-ToEmail" {
  name        = "/CI/MS/test/Forms/EgainPropertyManagerService/ToEmail"
  type        = "String"
  value       = "mary.crawford@client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Forms-EmailServiceEndPoint" {
  name        = "/CI/MS/test/Forms/EmailServiceEndPoint"
  type        = "String"
  value       = "http://10.41.12.25/NonHttclientmail/Service1.svc"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "FreeLightBulbs-EFIEndpoint" {
  name        = "/CI/MS/test/Forms/FreeLightBulbs/EFIEndpoint"
  type        = "String"
  value       = "https://testwebsvc3.url.client.com/SitProxy/EfiLedBulb"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Renewable-ServiceUrl" {
  name        = "/CI/MS/test/Forms/Renewable/ServiceUrl"
  type        = "String"
  value       = "http://url.client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "LEGACY_client-NotOutPort" {
  name        = "/CI/MS/test/LEGACY_client/NotOutPort"
  type        = "String"
  value       = "8081"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "LEGACY_client-URL" {
  name        = "/CI/MS/test/LEGACY_client/URL"
  type        = "String"
  value       = "http://10.41.12.25"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "client-Not-Out" {
  name        = "/CI/MS/test/client/Not-Out/URL"
  type        = "String"
  value       = "http://${data.terraform_remote_state.infrastructure.third_party_alb_dns}"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "MCF-HOST" {
  name        = "/CI/MS/test/MCF/HOST"
  type        = "String"
  value       = "mcf.client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "MCF-PORT" {
  name        = "/CI/MS/test/MCF/PORT"
  type        = "String"
  value       = "8002"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "MCF-SSL_PORT" {
  name        = "/CI/MS/test/MCF/SSL_PORT"
  type        = "String"
  value       = "8005"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Notification-EmailServiceEndPoint" {
  name        = "/CI/MS/test/Notification/EmailServiceEndPoint"
  type        = "String"
  value       = "http://10.41.12.25/NonHttclientmail/Service1.svc"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Redis-URL" {
  name        = "/CI/MS/test/Redis/URL"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.redis_primary_endpoint_address},resolvedns=1,abortConnect=false"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "authentication-mcf-gateway" {
  name        = "/CI/MS/test/Authentication/Mcf/Gateway"
  type        = "String"
  value       = "MCF_QA_Gateway"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "SecurityQuestions-MaxAttemptsPerChallenge" {
  name        = "/CI/MS/test/Authentication/PasswordReset/MaxAttemptsPerChallenge"
  type        = "String"
  value       = "3"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "SecurityQuestions-MaxChallenges" {
  name        = "/CI/MS/test/Authentication/PasswordReset/MaxChallenges"
  type        = "String"
  value       = "2"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "SecurityQuestions-PasswordResetTimespanMinutes" {
  name        = "/CI/MS/test/Authentication/PasswordReset/TokenLifespanMinutes"
  type        = "String"
  value       = "15"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "SecurityQuestions-PasswordResetLockMinutes" {
  name        = "/CI/MS/test/Authentication/PasswordReset/LockMinutes"
  type        = "String"
  value       = "1440"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "SecurityQuestions-MaximumSet" {
  name        = "/CI/MS/test/Authentication/SecurityQuestions/MaximumSet"
  type        = "String"
  value       = "4"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "SecurityQuestions-MinimumSet" {
  name        = "/CI/MS/test/Authentication/SecurityQuestions/MinimumSet"
  type        = "String"
  value       = "2"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-LockUser-IncorrectPasswordRetentionMinutes" {
  name        = "/CI/MS/test/Authentication/LockUser/IncorrectPasswordRetentionMinutes"
  type        = "String"
  value       = "15"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-LockUser-IncorrectPasswordLockMinutes" {
  name        = "/CI/MS/test/Authentication/LockUser/IncorrectPasswordLockMinutes"
  type        = "String"
  value       = "15"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-LockUser-IncorrectPasswordMaxAttempts" {
  name        = "/CI/MS/test/Authentication/LockUser/IncorrectPasswordMaxAttempts"
  type        = "String"
  value       = "5"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-Cognito-ClientId" {
  name        = "/CI/MS/test/Authentication/Cognito/ClientId"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.cognito_user_pool_client_id}"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-Cognito-ImpersonationClientId" {
  name        = "/CI/MS/test/Authentication/Cognito/ImpersonationClientId"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.cognito_user_pool_client_impersonation_id}"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-ResetPassword-SiteCorePasswordResetUrlBase" {
  name        = "/CI/MS/test/Authentication/PasswordReset/SiteCorePasswordResetUrlBase"
  type        = "String"
  value       = "https://www-test.clientcom.url.client.com/reset-password?token="
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-OutageSession-SessionExpirationInMinutes" {
  name        = "/CI/MS/test/Authentication/OutageSession/SessionExpirationInMinutes"
  type        = "String"
  value       = "180"
  description = "Outage session Expiration in minutes"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Spa-ServiceUrl" {
  name        = "/CI/MS/test/Project/Spa/ServiceUrl"
  type        = "String"
  value       = "https://testwebsvc3.url.client.com/TestSpaService/Service.svc"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Outage-Queue-ExceptionInbox" {
  name        = "/CI/MS/test/Outage/Queue/ExceptionInbox"
  type        = "String"
  value       = "atilano.sanchez@client.com"
  description = "exception inbox for outage queues"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Outage-Queue-Default-RateLimit" {
  name        = "/CI/MS/test/Outage/Queue/Default/RateLimit"
  type        = "String"
  value       = "10"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Outage-Queue-ReportOutage-Namespace" {
  name        = "/CI/MS/test/Outage/Queue/Mcf/ReportOutage"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_outage_reportoutage}"
  description = "Outage report outage queue namespace"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "StreetLight-EndPointAddress" {
  name        = "/CI/MS/test/Forms/StreetLight/EndPointAddress"
  type        = "String"
  value       = "http://10.41.12.25/NonHttclientmail/Service1.svc"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "StreetLight-FromEmail" {
  name        = "/CI/MS/test/Forms/StreetLight/FromEmail"
  type        = "String"
  value       = "test@client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "StreetLight-Subject" {
  name        = "/CI/MS/test/Forms/StreetLight/Subject"
  type        = "String"
  value       = "STREET_LIGHT_OUTAGE"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "StreetLight-ToEmail" {
  name        = "/CI/MS/test/Forms/StreetLight/ToEmail"
  type        = "String"
  value       = "andrei.peshakov@client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "LEGACY_client-AnonymousCallsEndpoint" {
  name        = "/CI/MS/test/LEGACY_client/AnonymousCallsEndpoint"
  type        = "String"
  value       = "http://10.41.12.25/CustomerStage/AnonymousCalls/Service.svc"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-LockUser-DefaultLockHours" {
  name        = "/CI/MS/test/Authentication/LockUser/DefaultLockHours"
  type        = "String"
  value       = "1"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Document-MonthlyInsertURL" {
  name        = "/CI/MS/test/Document/MonthlyInsertURL"
  type        = "String"
  value       = "https://www-test.clientcom.url.client.com/-/media/bill-inserts/"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Document-DocumentHistoryBaseURL" {
  name        = "/CI/MS/test/Document/DocumentHistoryBaseURL"
  type        = "String"
  value       = "/sap/opu/odata/sap/ZERP_UTILITIES_UMC_client_SRV/CorrespondenceDatas"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Statement-AWSProfile" {
  name        = "/CI/MS/test/Statement/AWSQureReader/AWSProfileName"
  type        = "String"
  value       = "clientDev"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Notification-PreferenceUpdate-SNSTopicARN" {
  name        = "/CI/MS/test/Notification/PreferenceUpdate/SNSTopicARN"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sns_notification_preference_update}"
  description = "SNS Topic to publish the Notification Preference Update event message to"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Notification-SendNotification-SNSTopicARN" {
  name        = "/CI/MS/test/Notification/SendNotification/SNSTopicARN"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sns_notification_send_notification}"
  description = "SNS Topic to publish the Send Notification event message to"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CommGateway-ServiceRelay-SNSTopicARN" {
  name        = "/CI/MS/test/CommGateway/ServiceRelay-SNSTopicARN"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sns_commgateway_servicerelay}"
  description = "SNS Topic to publish the Service Relay event message to"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "MB-ApiEndpoint" {
  name        = "/CI/MS/test/MB/ApiEndpoint"
  type        = "String"
  value       = "https://clientqa.messagebroadcast.com/v1"
  description = ""
  tags = "${var.default_tags}"
}

#Commgateway-prefUp-sap
resource "aws_ssm_parameter" "Commgateway-PrefUp-SAP-AWSSQSQueueUrl" {
  name        = "/CI/MS/test/CommGateway/prefUp-sap-SQS"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_commgateway_prefUp_sap}"
  description = "AWS SQS Queue name for Commgateway PrefUp SAP"
  tags = "${var.default_tags}"
}

#Commgateway-prefUp-mb
resource "aws_ssm_parameter" "Commgateway-PrefUp-MB-AWSSQSQueueUrl" {
  name        = "/CI/MS/test/CommGateway/prefUp-mb-SQS"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_commgateway_prefUp_mb}"
  description = "AWS SQS Queue name for Commgateway PrefUp MB"
  tags = "${var.default_tags}"
}

#Commgateway-service-relay
resource "aws_ssm_parameter" "Commgateway-Service-Relay-AWSSQSQueueUrl" {
  name        = "/CI/MS/test/CommGateway/service-relay-SQS"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_commgateway_service_relay}"
  description = "AWS SQS Queue name for Commgateway Service Relay"
  tags = "${var.default_tags}"
}

#Commgateway-message-intercept
resource "aws_ssm_parameter" "Commgateway-Message-Intercept-AWSSQSQueueUrl" {
  name        = "/CI/MS/test/CommGateway/message-intercept-SQS"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_commgateway_message_intercept}"
  description = "AWS SQS Queue name for Commgateway Message Intercept"
  tags = "${var.default_tags}"
}

#Begin AWSSQS Queues for MicroServices

#Account
resource "aws_ssm_parameter" "Account-AWSSQSQueueUrl" {
  name        = "/CI/MS/test/Account/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_account}"
  description = "AWS SQS Queue name for Account microservice"
  tags = "${var.default_tags}"
}

#Customer
resource "aws_ssm_parameter" "Customer-AWSSQSQueueUrl" {
  name        = "/CI/MS/test/Customer/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_customer}"
  description = "AWS SQS Queue name for Customer microservice"
  tags = "${var.default_tags}"
}

#Device
resource "aws_ssm_parameter" "Device-AWSSQSQueueUrl" {
  name        = "/CI/MS/test/Device/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_device}"
  description = "AWS SQS Queue name for Device microservice"
  tags = "${var.default_tags}"
}

#Payment
resource "aws_ssm_parameter" "Payment-AWSSQSQueueUrl" {
  name        = "/CI/MS/test/Payment/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_payment}"
  description = "AWS SQS Queue name for Payment microservice"
  tags = "${var.default_tags}"
}

#Statement
resource "aws_ssm_parameter" "Statement-AWSSQSQueueUrl" {
  name        = "/CI/MS/test/Statement/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_statement}"
  description = "AWS SQS Queue name for Statement microservice"
  tags = "${var.default_tags}"
}

#Budget Bill
resource "aws_ssm_parameter" "BudgetBill-AWSSQSQueueUrl" {
  name        = "/CI/MS/test/BudgetBill/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_budgetbill}"
  description = "AWS SQS Queue name for BudgetBill microservice"
  tags = "${var.default_tags}"
}

#End AWSSQS Queues for MicroServices

resource "aws_ssm_parameter" "Authentication-ResetPassword-BusinessCategory" {
  name        = "/CI/MS/test/Authentication/PasswordReset/BusinessCategory"
  type        = "String"
  value       = "Account_Services"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-ResetPassword-BusinessSubCategory" {
  name        = "/CI/MS/test/Authentication/PasswordReset/BusinessSubCategory"
  type        = "String"
  value       = "MA-07-001"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-UserActivity-BusinessCategory" {
  name        = "/CI/MS/test/Authentication/UserActivity/BusinessCategory"
  type        = "String"
  value       = "Account_Services"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-UserActivity-BusinessSubCategory" {
  name        = "/CI/MS/test/Authentication/UserActivity/BusinessSubCategory"
  type        = "String"
  value       = "MA-07-001"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-LEGACY_client-SamlTokenUrl" {
  name        = "/CI/MS/test/Authentication/LEGACY_client/SamlTokenUrl"
  type        = "String"
  value       = "http://10.41.12.24/SamlGeneratorUat/OpowerSaml.svc"
  description = ""
  tags = "${var.default_tags}"
}
resource "aws_ssm_parameter" "Authentication-Logging-MinimumLevel" {
  name        = "/CI/MS/test/Authentication/Logging/MinimumLevel"
  type        = "String"
  value       = "Debug"
  description = ""
  tags = "${var.default_tags}"
}
resource "aws_ssm_parameter" "Document-Logging-MinimumLevel" {
  name        = " /CI/MS/test/document/Logging/MinimumLevel"
  type        = "String"
  value       = "Debug"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Outage-Logging-MinimumLevel" {
  name        = " /CI/MS/test/outage/Logging/MinimumLevel"
  type        = "String"
  value       = "Debug"
  description = ""
  tags = "${var.default_tags}"
}
resource "aws_ssm_parameter" "Shared-Logging-MinimumLevel" {
  name        = "/CI/MS/test/Shared/Logging/MinimumLevel"
  type        = "String"
  value       = "Information"
  description = ""
  tags = "${var.default_tags}"
}
resource "aws_ssm_parameter" "Outage-Host" {
  name        = "/CI/MS/test/OutageServicesApi/Host"
  type        = "String"
  value       = "http://${data.terraform_remote_state.infrastructure.third_party_alb_dns}"
  description = "Host for Outage Services Api"
  tags = "${var.default_tags}"
}

