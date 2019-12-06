resource "aws_cloudwatch_dashboard" "sqs-monitoring-dashboard" {
  dashboard_name = "Microservices-SQS-Monitor-${title(var.env[terraform.workspace])}"

  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 24,
      "height": 6,
      "properties": { 
        "metrics": [ 
          [
            "AWS/SQS",
            "ApproximateNumberOfMessagesVisible",
            "QueueName",
            "${module.commgateway-message-intercept.name}",
            {
              "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "ApproximateNumberOfMessagesVisible",
            "QueueName",
            "${module.commgateway-prefUp-mb.name}",
            {
              "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "ApproximateNumberOfMessagesVisible",
            "QueueName",
            "${module.commgateway-prefUp-sap.name}",
            {
              "stat": "Sum"
            }
          ],
          [
            "...",
            "${module.commgateway-service-relay.name}",
            {
              "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "ApproximateNumberOfMessagesVisible",
            "QueueName",
            "${module.loader-account.name}",
            {
              "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "ApproximateNumberOfMessagesVisible",
            "QueueName",
            "${module.loader-budgetbill.name}",
            {
              "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "ApproximateNumberOfMessagesVisible",
            "QueueName",
            "${module.loader-customer.name}",
            {
              "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "ApproximateNumberOfMessagesVisible",
            "QueueName",
            "${module.loader-device.name}",
            {
              "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "ApproximateNumberOfMessagesVisible",
            "QueueName",
            "ci-dev-loader-file-available",
            {
              "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "ApproximateNumberOfMessagesVisible",
            "QueueName",
            "${module.loader-payment.name}",
            {
              "stat": "Sum"
             }
          ],
          [
            "AWS/SQS",
            "ApproximateNumberOfMessagesVisible",
            "QueueName",
            "${module.loader-statement.name}",
            {
              "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "ApproximateNumberOfMessagesVisible",
            "QueueName",
            "${module.oei-sms-msg.name}",
            {
              "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "ApproximateNumberOfMessagesVisible",
            "QueueName",
            "${module.oei-email-msg.name}",
            {
              "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "ApproximateNumberOfMessagesVisible",
            "QueueName",
            "${module.oei-voice-msg.name}",
            {
              "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "ApproximateNumberOfMessagesVisible",
            "QueueName",
            "${module.outage-reportoutage.name}",
            {
              "stat": "Sum"
            }
          ]
        ],
        "view": "timeSeries",
        "stacked": false,
        "region": "${var.region}", 
        "start": "-P1D",
        "end": "P0D",
        "period": 300,
        "title": "Approximate Number Of Messages Visible - ${title(var.env[terraform.workspace])}"
        }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 6,
      "width": 24,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
            "${module.commgateway-message-intercept.name}",
            {
	            "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
            "${module.commgateway-prefUp-mb.name}",
            {
	            "stat": "Sum"
	          }
          ],
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
            "${module.commgateway-prefUp-sap.name}",
            {
	            "stat": "Sum"
          	}
          ],
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
  	        "${module.commgateway-service-relay.name}",
            {
	          	"stat": "Sum"
          	}
          ],
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
            "${module.loader-account.name}",
            {
	            "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
            "${module.loader-budgetbill.name}",
            {
            	"stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
            "${module.loader-customer.name}",
            {
            	"stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
            "${module.loader-device.name}",
            {
	            "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
      	    "ci-dev-loader-file-available",
    	      {
		          "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
      	    "${module.loader-payment.name}",
    	      {
		          "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
          	"${module.loader-statement.name}",
          	{
          		"stat": "Sum"
          	}
          ],
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
      	    "${module.oei-email-msg.name}",
    	      {
		          "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
            "${module.oei-sms-msg.name}",
            {
	            "stat": "Sum"
            }
          ],
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
    	      "${module.oei-voice-msg.name}",
      	    {
        		  "stat": "Sum"
          	}
          ],
          [
            "AWS/SQS",
            "NumberOfMessagesDeleted",
            "QueueName",
          	"${module.outage-reportoutage.name}",
          	{
          		"stat": "Sum"
          	}
          ]
        ],
        "view": "timeSeries",
        "stacked": false,
        "region": "${var.region}",
        "start": "-P1D",
        "end": "P0D",
        "period": 300,
        "title": "Number of Messages Deleted - ${title(var.env[terraform.workspace])}"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 12,
      "width": 24,
      "height": 6,
      "properties": {
        "metrics": [ 
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
	          "${module.commgateway-message-intercept.name}",
	          {
		          "stat": "Average"
	          }
          ],
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
	          "${module.commgateway-prefUp-mb.name}",
	          {
		          "stat": "Average"
	          }
          ],
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
      	    "${module.commgateway-prefUp-sap.name}",
        	  {
          		"stat": "Average"
          	}
          ],
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
  	        "${module.commgateway-service-relay.name}",
    	      {
      		    "stat": "Average"
	          }
          ],
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
          	"${module.loader-account.name}",
          	{
          		"stat": "Average"
          	}
          ],
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
        	  "${module.loader-budgetbill.name}",
    	      {
  	  	      "stat": "Average"
	          }
          ],
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
        	  "${module.loader-customer.name}",
      	    {
  		        "stat": "Average"
	          }
          ],
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
        	  "${module.loader-device.name}",
      	    {
  		        "stat": "Average"
	          }
          ],
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
	          "ci-dev-loader-file-available",
      	    {
  		        "stat": "Average"
	          }
          ],
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
      	    "${module.loader-payment.name}",
    	      {
  	      	  "stat": "Average"
	          }
          ],
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
          	"${module.loader-statement.name}",
	          {
  		        "stat": "Average"
          	}
          ],
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
        	  "${module.oei-email-msg.name}",
      	    {
  		        "stat": "Average"
	          }
          ],
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
        	  "${module.oei-sms-msg.name}",
      	    {
  		        "stat": "Average"
	          }
          ],
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
        	  "${module.oei-voice-msg.name}",
      	    {
  		        "stat": "Average"
	          }
          ],
          [
	          "AWS/SQS",
	          "ApproximateAgeOfOldestMessage",
	          "QueueName",
        	  "${module.outage-reportoutage.name}",
      	    {
  		        "stat": "Average"
	          }
          ]
        ],
        "view": "timeSeries",
        "stacked": false,
        "region": "${var.region}",
        "start": "-P1D",
        "end": "P0D",
        "period": 300,
        "title": "Approximate Age Of Oldest Message - ${title(var.env[terraform.workspace])}"
      }
    }
  ]
}
EOF
}
