variable "queue_name" {}

variable "requiresPlatformNotification" {}
variable "requiresGeneralNotification" {}
variable "requiresNOCNotification" {}

variable "platformQueueAgeThreshold" {}
variable "generalQueueAgeThreshold" {}
variable "nocQueueAgeThreshold" {}

variable "platformSNSArn" {}
variable "generalSNSArn" {}
variable "nocSNSArn" {}
