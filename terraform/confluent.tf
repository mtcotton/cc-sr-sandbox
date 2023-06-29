# Cluster
resource "confluent_kafka_cluster" "sandbox_basic" {
    display_name = "Cotton SR DC Sandbox - Basic - ${random_id.env_display_id.hex}"
    availability = "SINGLE_ZONE"
    cloud = "AWS"
    region = var.aws_region
    basic {}
    environment {
        id = var.env_id
    }
}

resource "confluent_kafka_topic" "customers" {
    kafka_cluster {
        id          = confluent_kafka_cluster.sandbox_basic.id
    }
    topic_name      = "customers"
    rest_endpoint   = confluent_kafka_cluster.sandbox_basic.rest_endpoint
    credentials {
        key         = confluent_api_key.app-manager-kafka-api-key.id
        secret      = confluent_api_key.app-manager-kafka-api-key.secret
    }
}

// TODO: Use app manager once available
# resource "confluent_schema" "customer" {
#     schema_registry_cluster {
#         id          = var.env_sr_id
#     }
#     rest_endpoint   = var.env_sr_endpoint
#     subject_name    = "${confluent_kafka_topic.customers.topic_name}-value"
#     format          = "AVRO"
#     schema          = file("./schemas/avro/customer.avsc")
#     credentials {
#         key         = ???
#         secret      = ???
#     }
# }