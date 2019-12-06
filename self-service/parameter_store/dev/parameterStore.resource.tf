/* ==== **IMPORTANT** - Review the values within each resource (i.e. parameter) to ensure that the value is accurate. */
/* Failure to do so will result in the microservices pointing to the incorrect parameter */
/* Environment: dev */
## params not managed in terraform due to their protected values (username/passwords)
## these should be managed directly in the console by authorized users
#
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
#resource "aws_ssm_parameter" "Mcf-Landlord-User" {
#  name        = "/CI/MS/dev/MCF/Landlord/User"
#  type        = "String"
#  value       = "UMC_LRD_SRV"
#  description = ""
#  tags = "${var.default_tags}"
#}


## params managed by terraform, these should only be updated/created/destroyed in terraform, not the console

resource "aws_ssm_parameter" "AWSLogTarget-LogGroup" {
  name        = "/CI/MS/dev/AWSLogTarget/LogGroup"
  type        = "String"
  value       = "dev-account-history"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "AWSLogTarget-Region" {
  name        = "/CI/MS/dev/AWSLogTarget/Region"
  type        = "String"
  value       = "us-west-2"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-CliendID" {
  name        = "/CI/MS/dev/BillMatrix/CliendID"
  type        = "String"
  value       = "1629"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-PaymentChannel_Fee" {
  name        = "/CI/MS/dev/BillMatrix/PaymentChannel_Fee"
  type        = "String"
  value       = "I|L001629"
  description = "Anonymous payment channel with Fee"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-PaymentChannel_NoFee" {
  name        = "/CI/MS/dev/BillMatrix/PaymentChannel_NoFee"
  type        = "String"
  value       = "I|K001629"
  description = "Anonymous payment channel without Fee"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-PaymentChannel_Registered_Fee" {
  name        = "/CI/MS/dev/BillMatrix/PaymentChannel_Registered_Fee"
  type        = "String"
  value       = "I|J001629"
  description = "Non-Anonymous payment channel with Fee"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-PaymentChannel_Registered_NoFee" {
  name        = "/CI/MS/dev/BillMatrix/PaymentChannel_Registered_NoFee"
  type        = "String"
  value       = "I|I001629"
  description = "Non-Anonymous payment channel without Fee"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BillMatrix-Url" {
  name        = "/CI/MS/dev/BillMatrix/Url"
  type        = "String"
  value       = "https://btat2.paybill.com/consumer/account/FormPostLogIn?clientid=client_GUEST"
  description = "Base URL for BillMatrix payments"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BudgetBilling-MonthsBackValue" {
  name        = "/CI/MS/dev/BILLINGHISTORY/MONTHSBACK"
  type        = "String"
  value       = "24"
  description = "parameter for storing number of months back to look for budget billing history"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BucketName-Correspondence" {
  name        = "/CI/MS/dev/Document/BucketName/Correspondence"
  type        = "String"
  value       = "clientdevcorrespondence"
  description = "S3 bucket for correspondence documents"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "BucketName-Statements" {
  name        = "/CI/MS/dev/Document/BucketName/Statements"
  type        = "String"
  value       = "clientdevstatements"
  description = "S3 bucket for account statement documents"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-ConsistencyLevel" {
  name        = "/CI/MS/dev/CassandraSettings/ConsistencyLevel"
  type        = "String"
  value       = "LocalQuorum"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-Hosts" {
  name        = "/CI/MS/dev/CassandraSettings/Hosts"
  type        = "String"
  value       = "[{\"HostName\":\"10.128.42-204\",\"IpAddress\":\"10.128.42.204\"},{\"HostName\":\"10.128.42-114\",\"IpAddress\":\"10.128.42.114\"},{\"IpAddress\":\"10.128.45.50\"}]"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-MaxConnectionsFromHost" {
  name        = "/CI/MS/dev/CassandraSettings/MaxConnectionsFromHost"
  type        = "String"
  value       = "100"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-Port" {
  name        = "/CI/MS/dev/CassandraSettings/Port"
  type        = "String"
  value       = "9042"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-UseClusterCredentials" {
  name        = "/CI/MS/dev/CassandraSettings/UseClusterCredentials"
  type        = "String"
  value       = "true"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-UseQueryOptions" {
  name        = "/CI/MS/dev/CassandraSettings/UseQueryOptions"
  type        = "String"
  value       = "true"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CassandraSettings-UseSSL" {
  name        = "/CI/MS/dev/CassandraSettings/UseSSL"
  type        = "String"
  value       = "false"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Shared-CassandraKeyspace-Microservices" {
  name        = "/CI/MS/dev/Cassandra/Keyspace/Microservices"
  type        = "String"
  value       = "microservices"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Shared-CassandraKeyspace-SelfServiceAuth" {
  name        = "/CI/MS/dev/Cassandra/Keyspace/SelfServiceAuth"
  type        = "String"
  value       = "selfservice_auth"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "RegionEndpoint" {
  name        = "/CI/MS/dev/RegionEndpoint"
  type        = "String"
  value       = "us-west-2"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Cognito-UserPool" {
  name        = "/CI/MS/dev/Cognito/UserPool"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.cognito_user_pool_id}"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "ContractAccountValidator-CacheExpiration" {
  name        = "/CI/MS/dev/ContractAccountValidator/CacheExpiration"
  type        = "String"
  value       = "00:10:00"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Dev-ALB_URL" {
  name        = "/CI/MS/dev/ALB_URL"
  type        = "String"
  value       = "https://selfservice-dev-alb.client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "DQM-EndPointAddress" {
  name        = "/CI/MS/dev/DQM/EndPointAddress"
  type        = "String"
  value       = "https://dqm.client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "EgainPropertyManagerService-FromEmail" {
  name        = "/CI/MS/dev/Forms/EgainPropertyManagerService/FromEmail"
  type        = "String"
  value       = "test@client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "EgainPropertyManagerService-Subject" {
  name        = "/CI/MS/dev/Forms/EgainPropertyManagerService/Subject"
  type        = "String"
  value       = "Property_Manager"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "EgainPropertyManagerService-ToEmail" {
  name        = "/CI/MS/dev/Forms/EgainPropertyManagerService/ToEmail"
  type        = "String"
  value       = "mary.crawford@client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Forms-EmailServiceEndPoint" {
  name        = "/CI/MS/dev/Forms/EmailServiceEndPoint"
  type        = "String"
  value       = "http://10.41.12.25/NonHttclientmail/Service1.svc"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Renewable-ServiceUrl" {
  name        = "/CI/MS/dev/Forms/Renewable/ServiceUrl"
  type        = "String"
  value       = "http://url.client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "LEGACY_client-NotOutPort" {
  name        = "/CI/MS/dev/LEGACY_client/NotOutPort"
  type        = "String"
  value       = "8081"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "LEGACY_client-URL" {
  name        = "/CI/MS/dev/LEGACY_client/URL"
  type        = "String"
  value       = "http://10.41.12.25"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "client-Not-Out" {
  name        = "/CI/MS/dev/client/Not-Out/URL"
  type        = "String"
  value       = "http://${data.terraform_remote_state.infrastructure.third_party_alb_dns}"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "MCF-HOST" {
  name        = "/CI/MS/dev/MCF/HOST"
  type        = "String"
  value       = "mcf.client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "MCF-PORT" {
  name        = "/CI/MS/dev/MCF/PORT"
  type        = "String"
  value       = "8002"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "MCF-SSL_PORT" {
  name        = "/CI/MS/dev/MCF/SSL_PORT"
  type        = "String"
  value       = "8005"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Notification-EmailServiceEndPoint" {
  name        = "/CI/MS/dev/Notification/EmailServiceEndPoint"
  type        = "String"
  value       = "http://10.41.12.25/NonHttclientmail/Service1.svc"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Redis-URL" {
  name        = "/CI/MS/dev/Redis/URL"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.redis_primary_endpoint_address},resolvedns=1,abortConnect=false"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "authentication-mcf-gateway" {
  name        = "/CI/MS/dev/Authentication/Mcf/Gateway"
  type        = "String"
  value       = "MCF_QA_Gateway"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "PasswordReset-MaxAttemptsPerChallenge" {
  name        = "/CI/MS/dev/Authentication/PasswordReset/MaxAttemptsPerChallenge"
  type        = "String"
  value       = "3"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "PasswordReset-MaxChallenges" {
  name        = "/CI/MS/dev/Authentication/PasswordReset/MaxChallenges"
  type        = "String"
  value       = "2"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "SecurityQuestions-PasswordResetTimespanMinutes" {
  name        = "/CI/MS/dev/Authentication/PasswordReset/TokenLifespanMinutes"
  type        = "String"
  value       = "15"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "SecurityQuestions-PasswordResetLockMinutes" {
  name        = "/CI/MS/dev/Authentication/PasswordReset/LockMinutes"
  type        = "String"
  value       = "1440"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "SecurityQuestions-MaximumSet" {
  name        = "/CI/MS/dev/Authentication/SecurityQuestions/MaximumSet"
  type        = "String"
  value       = "4"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "SecurityQuestions-MinimumSet" {
  name        = "/CI/MS/dev/Authentication/SecurityQuestions/MinimumSet"
  type        = "String"
  value       = "2"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-LockUser-IncorrectPasswordRetentionMinutes" {
  name        = "/CI/MS/dev/Authentication/LockUser/IncorrectPasswordRetentionMinutes"
  type        = "String"
  value       = "15"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-LockUser-IncorrectPasswordLockMinutes" {
  name        = "/CI/MS/dev/Authentication/LockUser/IncorrectPasswordLockMinutes"
  type        = "String"
  value       = "15"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-LockUser-IncorrectPasswordMaxAttempts" {
  name        = "/CI/MS/dev/Authentication/LockUser/IncorrectPasswordMaxAttempts"
  type        = "String"
  value       = "5"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-Cognito-ClientId" {
  name        = "/CI/MS/dev/Authentication/Cognito/ClientId"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.cognito_user_pool_client_id}"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-Cognito-ImpersonationClientId" {
  name        = "/CI/MS/dev/Authentication/Cognito/ImpersonationClientId"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.cognito_user_pool_client_impersonation_id}"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-Cognito-AdminClientId" {
  name        = "/CI/MS/dev/Authentication/Cognito/AdminClientId"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.cognito_user_pool_client_impersonation_id}"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-ResetPassword-SiteCorePasswordResetUrlBase" {
  name        = "/CI/MS/dev/Authentication/PasswordReset/SiteCorePasswordResetUrlBase"
  type        = "String"
  value       = "https://www-dev.clientcom.url.client.com/reset-password?token="
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-OutageSession-SessionExpirationInMinutes" {
  name        = "/CI/MS/dev/Authentication/OutageSession/SessionExpirationInMinutes"
  type        = "String"
  value       = "180"
  description = "Outage session Expiration in minutes"
}

resource "aws_ssm_parameter" "Outage-Queue-ExceptionInbox" {
  name        = "/CI/MS/dev/Outage/Queue/ExceptionInbox"
  type        = "String"
  value       = "ms-exception-inbox@client.com"
  description = "exception inbox for outage queues"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Outage-Queue-Default-RateLimit" {
  name        = "/CI/MS/dev/Outage/Queue/Default/RateLimit"
  type        = "String"
  value       = "10"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Outage-Queue-ReportOutage-Namespace" {
  name        = "/CI/MS/dev/Outage/Queue/Mcf/ReportOutage"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_outage_reportoutage}"
  description = "Outage report outage queue namespace"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Spa-ServiceUrl" {
  name        = "/CI/MS/dev/Project/Spa/ServiceUrl"
  type        = "String"
  value       = "https://sqvlswssv01v01.url.client.com/TestSpaService_twsvc3/Service.svc"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "StreetLight-EndPointAddress" {
  name        = "/CI/MS/dev/Forms/StreetLight/EndPointAddress"
  type        = "String"
  value       = "http://10.41.12.25/NonHttclientmail/Service1.svc"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "StreetLight-FromEmail" {
  name        = "/CI/MS/dev/Forms/StreetLight/FromEmail"
  type        = "String"
  value       = "test@client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "StreetLight-Subject" {
  name        = "/CI/MS/dev/Forms/StreetLight/Subject"
  type        = "String"
  value       = "STREET_LIGHT_OUTAGE"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "StreetLight-ToEmail" {
  name        = "/CI/MS/dev/Forms/StreetLight/ToEmail"
  type        = "String"
  value       = "andrei.peshakov@client.com"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "LEGACY_client-AnonymousCallsEndpoint" {
  name        = "/CI/MS/dev/LEGACY_client/AnonymousCallsEndpoint"
  type        = "String"
  value       = "http://10.41.12.25/CustomerStage/AnonymousCalls/Service.svc"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-LockUser-DefaultLockHours" {
  name        = "/CI/MS/dev/Authentication/LockUser/DefaultLockHours"
  type        = "String"
  value       = "1"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Document-MonthlyInsertURL" {
  name        = "/CI/MS/dev/Document/MonthlyInsertURL"
  type        = "String"
  value       = "https://www-dev.clientcom.url.client.com/-/media/bill-inserts/"
  description = "Base URL for document insert links"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Document-DocumentHistoryBaseURL" {
  name        = "/CI/MS/dev/Document/DocumentHistoryBaseURL"
  type        = "String"
  value       = "/sap/opu/odata/sap/ZERP_UTILITIES_UMC_client_SRV/CorrespondenceDatas"
  description = "Base URL for MCF document history"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Notification-PreferenceUpdate-SNSTopicARN" {
  name        = "/CI/MS/dev/Notification/PreferenceUpdate/SNSTopicARN"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sns_notification_preference_update}"
  description = "SNS Topic to publish the Notification Preference Update event message to"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Notification-SendNotification-SNSTopicARN" {
  name        = "/CI/MS/dev/Notification/SendNotification/SNSTopicARN"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sns_notification_send_notification}"
  description = "SNS Topic to publish the Send Notification event message to"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "CommGateway-ServiceRelay-SNSTopicARN" {
  name        = "/CI/MS/dev/CommGateway/ServiceRelay-SNSTopicARN"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sns_commgateway_servicerelay}"
  description = "SNS Topic to publish the Service Relay event message to"
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "MB-ApiEndpoint" {
  name        = "/CI/MS/dev/MB/ApiEndpoint"
  type        = "String"
  value       = "https://clientqa.messagebroadcast.com/v1"
  description = ""
  tags = "${var.default_tags}"
}

#Commgateway-prefUp-sap 
resource "aws_ssm_parameter" "Commgateway-PrefUp-SAP-AWSSQSQueueUrl" {
  name        = "/CI/MS/dev/CommGateway/prefUp-sap-SQS"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_commgateway_prefUp_sap}"
  description = "AWS SQS Queue name for Commgateway PrefUp SAP"
  tags = "${var.default_tags}"
}

#Commgateway-prefUp-mb
resource "aws_ssm_parameter" "Commgateway-PrefUp-MB-AWSSQSQueueUrl" {
  name        = "/CI/MS/dev/CommGateway/prefUp-mb-SQS"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_commgateway_prefUp_mb}"
  description = "AWS SQS Queue name for Commgateway PrefUp MB"
  tags = "${var.default_tags}"
}

#Commgateway-service-relay
resource "aws_ssm_parameter" "Commgateway-Service-Relay-AWSSQSQueueUrl" {
  name        = "/CI/MS/dev/CommGateway/service-relay-SQS"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_commgateway_service_relay}"
  description = "AWS SQS Queue name for Commgateway Service Relay"
  tags = "${var.default_tags}"
}

#Commgateway-message-intercept
resource "aws_ssm_parameter" "Commgateway-Message-Intercept-AWSSQSQueueUrl" {
  name        = "/CI/MS/dev/CommGateway/message-intercept-SQS"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_commgateway_message_intercept}"
  description = "AWS SQS Queue name for Commgateway Message Intercept"
  tags = "${var.default_tags}"
}

#Begin AWSSQS Queues for MicroServices

#Account
resource "aws_ssm_parameter" "Account-AWSSQSQueueUrl" {
  name        = "/CI/MS/dev/Account/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_account}"
  description = "AWS SQS Queue name for Account microservice"
  tags = "${var.default_tags}"
}

#Customer
resource "aws_ssm_parameter" "Customer-AWSSQSQueueUrl" {
  name        = "/CI/MS/dev/Customer/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_customer}"
  description = "AWS SQS Queue name for Customer microservice"
  tags = "${var.default_tags}"
}

#Device
resource "aws_ssm_parameter" "Device-AWSSQSQueueUrl" {
  name        = "/CI/MS/dev/Device/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_device}"
  description = "AWS SQS Queue name for Device microservice"
  tags = "${var.default_tags}"
}

#Payment
resource "aws_ssm_parameter" "Payment-AWSSQSQueueUrl" {
  name        = "/CI/MS/dev/Payment/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_payment}"
  description = "AWS SQS Queue name for Payment microservice"
  tags = "${var.default_tags}"
}

#Statement
resource "aws_ssm_parameter" "Statement-AWSSQSQueueUrl" {
  name        = "/CI/MS/dev/Statement/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_statement}"
  description = "AWS SQS Queue name for Statement microservice"
  tags = "${var.default_tags}"
}

#Budget Bill
resource "aws_ssm_parameter" "BudgetBill-AWSSQSQueueUrl" {
  name        = "/CI/MS/dev/BudgetBill/AWSQueueReader/AWSSQSQueueUrl"
  type        = "String"
  value       = "${data.terraform_remote_state.infrastructure.sqs_loader_budgetbill}"
  description = "AWS SQS Queue name for BudgetBill microservice"
  tags = "${var.default_tags}"
}

#End AWSSQS Queues for MicroServices

resource "aws_ssm_parameter" "Authentication-ResetPassword-BusinessCategory" {
  name        = "/CI/MS/dev/Authentication/PasswordReset/BusinessCategory"
  type        = "String"
  value       = "Account_Services"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-ResetPassword-BusinessSubCategory" {
  name        = "/CI/MS/dev/Authentication/PasswordReset/BusinessSubCategory"
  type        = "String"
  value       = "MA-07-001"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-UserActivity-BusinessCategory" {
  name        = "/CI/MS/dev/Authentication/UserActivity/BusinessCategory"
  type        = "String"
  value       = "Account_Services"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-UserActivity-BusinessSubCategory" {
  name        = "/CI/MS/dev/Authentication/UserActivity/BusinessSubCategory"
  type        = "String"
  value       = "MA-07-001"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-LEGACY_client-SamlTokenUrl" {
  name        = "/CI/MS/dev/Authentication/LEGACY_client/SamlTokenUrl"
  type        = "String"
  value       = "http://10.41.12.24/SamlGeneratorUat/OpowerSaml.svc"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Authentication-Logging-MinimumLevel" {
  name        = "/CI/MS/dev/Authentication/Logging/MinimumLevel"
  type        = "String"
  value       = "Debug"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Document-Logging-MinimumLevel" {
  name        = " /CI/MS/dev/document/Logging/MinimumLevel"
  type        = "String"
  value       = "Debug"
  description = ""
  tags = "${var.default_tags}"
}


resource "aws_ssm_parameter" "Outage-Logging-MinimumLevel" {
  name        = " /CI/MS/dev/outage/Logging/MinimumLevel"
  type        = "String"
  value       = "Debug"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Shared-Logging-MinimumLevel" {
  name        = "/CI/MS/dev/Shared/Logging/MinimumLevel"
  type        = "String"
  value       = "Information"
  description = ""
  tags = "${var.default_tags}"
}

resource "aws_ssm_parameter" "Outage-Host" {
  name        = "/CI/MS/dev/OutageServicesApi/Host"
  type        = "String"
  value       = "http://${data.terraform_remote_state.infrastructure.third_party_alb_dns}"
  description = "Host for Outage Services Api"
  tags = "${var.default_tags}"
}
