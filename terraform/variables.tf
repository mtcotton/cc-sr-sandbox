variable "env_id" {
    type = string
    nullable = false
}

variable "confluent_cloud_api_key" {
    description = "Confluent Cloud API Key (also referred as Cloud API ID)"
    type        = string
    nullable    = false
}

variable "confluent_cloud_api_secret" {
    description = "Confluent Cloud API Secret"
    type        = string
    sensitive   = true
    nullable    = false
}

variable "aws_region" {
    type = string
    nullable = false
    default = "us-east-2"
}