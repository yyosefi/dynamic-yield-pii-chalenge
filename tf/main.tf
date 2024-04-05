# https://developer.hashicorp.com/terraform/cli/config/config-file

terraform {
  required_version = "1.7.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.44.0"
    }
  }
}

provider "aws" {
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration

  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/guides/custom-service-endpoints#localstack
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  region                      = "us-east-1"
  access_key                  = "dummy"
  secret_key                  = "dummy"


  endpoints {
    # docker-compose run --rm curl | jq '.services'
    # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/guides/custom-service-endpoints#available-endpoint-customizations
    acm                      = "http://localstack:4566"
    apigateway               = "http://localstack:4566"
    cloudformation           = "http://localstack:4566"
    cloudwatch               = "http://localstack:4566"
    config                   = "http://localstack:4566"
    dynamodb                 = "http://localstack:4566"
    ecr                      = "http://localstack:4566"
    ec2                      = "http://localstack:4566"
    es                       = "http://localstack:4566"
    events                   = "http://localstack:4566"
    firehose                 = "http://localstack:4566"
    iam                      = "http://localstack:4566"
    kinesis                  = "http://localstack:4566"
    kms                      = "http://localstack:4566"
    lambda                   = "http://localstack:4566"
    logs                     = "http://localstack:4566"
    opensearch               = "http://localstack:4566"
    redshift                 = "http://localstack:4566"
    resourcegroups           = "http://localstack:4566"
    resourcegroupstaggingapi = "http://localstack:4566"
    route53                  = "http://localstack:4566"
    route53resolver          = "http://localstack:4566"
    s3                       = "http://localstack:4566"
    s3control                = "http://localstack:4566"
    secretsmanager           = "http://localstack:4566"
    ses                      = "http://localstack:4566"
    sns                      = "http://localstack:4566"
    sqs                      = "http://localstack:4566"
    ssm                      = "http://localstack:4566"
    stepfunctions            = "http://localstack:4566"
    sts                      = "http://localstack:4566"
    swf                      = "http://localstack:4566"
    transcribe               = "http://localstack:4566"
  }
}
