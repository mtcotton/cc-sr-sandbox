terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "4.46"
        }
        confluent = {
            source = "confluentinc/confluent"
            version = "1.46.0"
        }
    }
}

provider "confluent" {
    cloud_api_key    = var.confluent_cloud_api_key
    cloud_api_secret = var.confluent_cloud_api_secret
}

# Random bytestring to uniquify resources - useful in heavily multi-user sandboxes - "
resource "random_id" "env_display_id" {
    byte_length = 4
}