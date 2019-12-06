/* ==== service vars ==== */
variable "service_names" {
  type    = "list"

  default = ["account", "account-history", "address", "authentication", "budget-bill", "cognito-app", "commgateway", "customer", "deferral", "device", "document", "installment", "forms", "payment", "notification", "outage", "project", "statement", "swagger-ui", "aspnetcore-build", "aspnetcore-runtime"]

}

# Create ECR
resource "aws_ecr_repository" "repo" {
  count = "${length(var.service_names)}"

  name = "${element(var.service_names, count.index)}"
}

resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  depends_on = ["aws_ecr_repository.repo"]

  count = "${length(var.service_names)}"

  repository = "${element(var.service_names, count.index)}"

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Maintain the last 30 Prod Docker images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["prod-"],
                "countType": "imageCountMoreThan",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Maintain Production Docker images for a year",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["prod"],
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 365
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 5,
            "description": "Maintain the last 15 QA Docker images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["qa"],
                "countType": "imageCountMoreThan",
                "countNumber": 15
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 10,
            "description": "Maintain the last 10 Test-Feature Docker images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["test-ft"],
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 15,
            "description": "Maintain the last 10 Test Docker images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["test"],
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 20,
            "description": "Maintain the last 5 Dev-FT Docker images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["dev-ft"],
                "countType": "imageCountMoreThan",
                "countNumber": 5
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 25,
            "description": "Maintain the last 5 Dev Docker images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["dev"],
                "countType": "imageCountMoreThan",
                "countNumber": 5
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 30,
            "description": "Expire untagged images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}


# Creates ECR Policies for service role

resource "aws_ecr_repository_policy" "ecrpolicy" {
  depends_on = ["aws_ecr_repository.repo"]

  count = "${length(var.service_names)}"

  repository = "${element(var.service_names, count.index)}"

  policy = <<EOF
{
      "Version": "2008-10-17",
      "Statement": [
          {
              "Sid": "Development-RepoAccess",
              "Effect": "Allow",
              "Principal": {
                  "AWS": [
                      "${data.terraform_remote_state.dev_ft_infrastructure.ecs_ecsTaskExecutionRole_id}",
                      "${data.terraform_remote_state.dev_ft_infrastructure.ecs_task_role_id}",
                      "arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:user/AWSDevUser"
                  ]
              },
              "Action": [
                  "ecr:GetDownloadUrlForLayer",
                  "ecr:BatchGetImage",
                  "ecr:BatchCheckLayerAvailability"
              ]
          },
          {
              "Sid": "Development-RepoAccess",
              "Effect": "Allow",
              "Principal": {
                  "AWS": [
                      "${data.terraform_remote_state.dev_infrastructure.ecs_ecsTaskExecutionRole_id}",
                      "${data.terraform_remote_state.dev_infrastructure.ecs_task_role_id}",
                      "arn:aws:iam::###CENSORED-DEV-ACCOUNT-NUMBER###:user/AWSDevUser"
                  ]
              },
              "Action": [
                  "ecr:GetDownloadUrlForLayer",
                  "ecr:BatchGetImage",
                  "ecr:BatchCheckLayerAvailability"
              ]
          },
          {
              "Sid": "Test1-RepoAccess",
              "Effect": "Allow",
              "Principal": {
                  "AWS": [
                     "arn:aws:iam::###CENSORED-TEST-ACCOUNT-NUMBER###:role/ci-test1-ecsTaskExecutionRole",
                     "arn:aws:iam::###CENSORED-TEST-ACCOUNT-NUMBER###:role/ci-test1-ecsTaskRole"
                  ]
              },
              "Action": [
                  "ecr:GetDownloadUrlForLayer",
                  "ecr:BatchGetImage",
                  "ecr:BatchCheckLayerAvailability"
              ]
          },
          {
              "Sid": "Test-RepoAccess",
              "Effect": "Allow",
              "Principal": {
                  "AWS": [
                      "${data.terraform_remote_state.test_infrastructure.ecs_ecsTaskExecutionRole_id}",
                      "${data.terraform_remote_state.test_infrastructure.ecs_task_role_id}"
                  ]
              },
              "Action": [
                  "ecr:GetDownloadUrlForLayer",
                  "ecr:BatchGetImage",
                  "ecr:BatchCheckLayerAvailability"
              ]
          },
          {
              "Sid": "Test-FT-RepoAccess",
              "Effect": "Allow",
              "Principal": {
                  "AWS": [
                      "${data.terraform_remote_state.test_ft_infrastructure.ecs_ecsTaskExecutionRole_id}",
                      "${data.terraform_remote_state.test_ft_infrastructure.ecs_task_role_id}"
                  ]
              },
              "Action": [
                  "ecr:GetDownloadUrlForLayer",
                  "ecr:BatchGetImage",
                  "ecr:BatchCheckLayerAvailability"
              ]
          },
          {
              "Sid": "PreProd-RepoAccess",
              "Effect": "Allow",
              "Principal": {
                  "AWS": [
                      "${data.terraform_remote_state.qa_infrastructure.ecs_ecsTaskExecutionRole_id}",
                      "${data.terraform_remote_state.qa_infrastructure.ecs_task_role_id}",
                      "arn:aws:iam::###CENSORED-QA-ACCOUNT-NUMBER###:role/ci-WebTFSBuildRole",
                      "arn:aws:iam::###CENSORED-QA-ACCOUNT-NUMBER###:role/APP-BuildServerRole"
                  ]
              },
              "Action": [
                  "ecr:GetDownloadUrlForLayer",
                  "ecr:BatchGetImage",
                  "ecr:BatchCheckLayerAvailability"
              ]
          },
          {
              "Sid": "TFS-RW-Access",
              "Effect": "Allow",
              "Principal": {
                  "AWS": [
                     "arn:aws:iam::###CENSORED-QA-ACCOUNT-NUMBER###:role/ci-WebTFSBuildRole",
                     "arn:aws:iam::###CENSORED-QA-ACCOUNT-NUMBER###:role/APP-BuildServerRole"
                  ]
              },
              "Action": [
                    "ecr:PutImage",
                    "ecr:InitiateLayerUpload",
                    "ecr:UploadLayerPart",
                    "ecr:CompleteLayerUpload"
              ]
          },
          {
            "Sid": "Prod-RO-Access",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "${data.terraform_remote_state.prod_infrastructure.ecs_ecsTaskExecutionRole_id}",
                    "${data.terraform_remote_state.prod_infrastructure.ecs_task_role_id}"
                ]
            },
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability"
            ]
          },
          {
            "Sid": "Deny-RepoWriteAccess",
            "Effect": "Deny",
            "Principal": "*",
            "Action": [
              "ecr:PutImage",
              "ecr:InitiateLayerUpload",
              "ecr:UploadLayerPart",
              "ecr:CompleteLayerUpload"
            ],
            "Condition": {
              "StringNotLike": {
                "aws:userid": [
                  "###CENSORED-SHARED-SERVICES-CAN-ID###:*",
                  "###CENSORED-QA-ACCOUNT-NUMBER###"
                ]
              }
            }
          }
      ]
  }
  EOF
}
