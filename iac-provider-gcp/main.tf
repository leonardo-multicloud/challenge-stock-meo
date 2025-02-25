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
  name     = "challenge-meo"
  location = "europe-west1"
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"
  project = data.google_project.project.project_id

  template {
    containers {
      image = "gcr.io/rare-gist-451920-p4/challenge-stock-meo:v1.0"
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
      env {
        name  = "FLASK_ENV"
        value = "production"
      }
    }
  }

  depends_on = [ data.google_project.project ]
}

resource "google_cloud_run_service_iam_binding" "default" {
  location = google_cloud_run_v2_service.challenge_stock_meo_backend.location
  service  = google_cloud_run_v2_service.challenge_stock_meo_backend.name
  project = data.google_project.project.project_id
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]

  depends_on = [ google_cloud_run_v2_service.challenge_stock_meo_backend ]
}