terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.22.0"
    }
  }
}

data "google_project" "project" {
    project_id = "rare-gist-451920-p4"
}

resource "google_cloud_run_v2_service" "challenge_stock_meo_backend" {
  name     = "cloudrun-service"
  location = "europe-west1"
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"
  project = data.google_project.project.project_id

  template {
    containers {
      image = "leonardomulticloud/challenge-stock-meo-backend:v1.0"
      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }

      env {
        name  = "API_KEY"
        value = ""
      }
    }
  }

  depends_on = [ data.google_project.project ]
}