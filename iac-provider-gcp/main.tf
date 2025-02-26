terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.22.0"
    }
  }
  
  backend "gcs" {
      bucket = "state_challenge_stock"
      prefix  = "terraform/state"
  }
}

data "google_project" "project" {
    project_id = "${var.project}"
}

resource "google_cloud_run_v2_service" "v1" {
  name     = "${var.google_cloud_run_name}"
  location = "${var.google_cloud_run_region}"
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"
  project = data.google_project.project.project_id

  template {
    containers {
      image = "${var.google_cloud_run_image}"
      resources {
        limits = {
          cpu    = "${var.google_cloud_run_limit_cpu}"
          memory = "${var.google_cloud_run_limit_mem}"
        }
      }

      env {
        name  = "API_KEY"
        value = "${var.google_cloud_run_api_key}"
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
  location = google_cloud_run_v2_service.v1.location
  service  = google_cloud_run_v2_service.v1.name
  project = data.google_project.project.project_id
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]

  depends_on = [ google_cloud_run_v2_service.v1 ]
}