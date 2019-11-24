# provider
provider "google" {
  region  = "us-central1"
}

# Staging bucket
resource "google_storage_bucket" "staging_bucket" {
  project  = var.project_id
  name     = "${var.project_id}-staging"
}

# Enable APIs
resource "google_project_service" "enabled_api" {
  for_each                   = toset(var.enabled_api)
  project                    = var.project_id
  service                    = each.key
  disable_dependent_services = false
}
