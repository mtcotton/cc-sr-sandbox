// Create topics, grant ACLS
resource "confluent_service_account" "app-manager" {
  display_name = "cotton-sandbox-app-manager-${random_id.env_display_id.hex}"
  description  = "Service account to manage Kafka cluster"
}

resource "confluent_role_binding" "app-manager-kafka-cluster-admin" {
  principal   = "User:${confluent_service_account.app-manager.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = confluent_kafka_cluster.sandbox_basic.rbac_crn
}

resource "confluent_api_key" "app-manager-kafka-api-key" {
  display_name = "app-manager-kafka-api-key"
  description  = "Kafka API Key that is owned by 'app-manager' service account"
  owner {
    id          = confluent_service_account.app-manager.id
    api_version = confluent_service_account.app-manager.api_version
    kind        = confluent_service_account.app-manager.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.sandbox_basic.id
    api_version = confluent_kafka_cluster.sandbox_basic.api_version
    kind        = confluent_kafka_cluster.sandbox_basic.kind

    environment {
      id = var.env_id
    }
  }
}

resource "confluent_service_account" "app-reader" {
    display_name    = "cotton-sandbox-app-reader-${random_id.env_display_id.hex}"
    description     = "Service account to read from Kafka cluster"
}

resource "confluent_api_key" "app-reader-kafka-api-key" {
  display_name = "app-reader-kafka-api-key"
  description  = "Kafka API Key that is owned by 'app-reader' service account"
  owner {
    id          = confluent_service_account.app-reader.id
    api_version = confluent_service_account.app-reader.api_version
    kind        = confluent_service_account.app-reader.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.sandbox_basic.id
    api_version = confluent_kafka_cluster.sandbox_basic.api_version
    kind        = confluent_kafka_cluster.sandbox_basic.kind

    environment {
      id = var.env_id
    }
  }
}

resource "confluent_service_account" "app-writer" {
    display_name    = "cotton-sandbox-app-writer-${random_id.env_display_id.hex}"
    description     = "Service account to write to Kafka cluster"
}

resource "confluent_api_key" "app-writer-kafka-api-key" {
  display_name = "app-writer-kafka-api-key"
  description  = "Kafka API Key that is owned by 'app-writer' service account"
  owner {
    id          = confluent_service_account.app-writer.id
    api_version = confluent_service_account.app-writer.api_version
    kind        = confluent_service_account.app-writer.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.sandbox_basic.id
    api_version = confluent_kafka_cluster.sandbox_basic.api_version
    kind        = confluent_kafka_cluster.sandbox_basic.kind

    environment {
      id = var.env_id
    }
  }
}