locals {
  region = "europe-west1"
}

terraform {
  backend "gcs" {
    bucket  = "finance_terraform"
    prefix  = "terraform/state"
  }
}

data "google_project" "default" {
  project_id = "finance-322907"
}

resource "google_storage_bucket" "database_dumps" {
  project = data.google_project.default.project_id
  name    = "${data.google_project.default.project_id}_database_dumps"
  location = local.region
  uniform_bucket_level_access = true
}


