Scrubbed Items and Instructions for Usage:


Scrubbed Items:
Terraform S3 State Bucket and Dynamo DB Table: ###CENSORED-S3-TERRAFORM-BUCKET###
STS VPC Endpoint: ###CENSORED-STS-VPC-ENDPOINT###
Development Account Number: ###CENSORED-DEV-ACCOUNT-NUMBER###
Test Account Number: ###CENSORED-TEST-ACCOUNT-NUMBER###
QA/Shared Services Account Number: ###CENSORED-QA-ACCOUNT-NUMBER###
Production Account Number: ###CENSORED-PROD-ACCOUNT-NUMBER###
QA/Shared Services Canonical ID: ###CENSORED-SHARED-SERVICES-CAN-ID###
CISCO Teams Bot ID: ###CENSORED-CISCO-TEAMS-BOT-ID###
Cisco Teams General Chat Room: ###CENSORED-CISCO-TEAMS-ROOM-ID###
Cisco Teams Detailed Chat Room: ###CENSORED-CISCO-TEAMS-ROOM-DETAILS-ID###

Directions for usage:
Terraform S3 State Bucket and Dynamo DB Table: Choose a unique name for your S3 bucket and DynamoDB table, the S3 bucket will be a global namespace across all accounts.  Example: client-terraform-state
STS VPC Endpoint: Usage of an STS endpoint is optional.  
Development Account Number: AWS account number for the development environment.
Test Account Number: AWS account number for the test environment.  In some cases this was shared with the client's development account.
QA/Shared Services Account Number: AWS account number for the QA and shared services environment.  Ideally a separate shared services and QA account will be established.
Production Account Number: AWS account number for the production environment.
QA/Shared Services Canonical ID: Canonical ID acquired via AWS CLI for the Shared Services account
CISCO Teams Bot ID: Created Bot ID for Cisco Teams integration of monitoring
Cisco Teams General Chat Room: General Chat Room ID for Cisco Teams integration.  Obtained via Cisco CLI.
Cisco Teams Detailed Chat Room: Detailed Chat Room ID for Cisco Teams integration.  Obtained via Cisco CLI.