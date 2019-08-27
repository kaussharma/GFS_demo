##################################################
# TF_VARS
##################################################
##Changed -Should be passed as TF_VARS from the concourse pipeline

variable "ReleaseVersion" {
  description = "release version of MLaaS "
  default     = "1.1"
}

variable "region" {
  description = "Target AWS region to deploy to"
  type        = "string"
}

variable "bucket" {
  description = "AWS S3 bucket folder to store Terraform state"
  type        = "string"
}

variable "dynamodb_table" {
  description = "AWS DynamoDB lock"
  type        = "string"
}
