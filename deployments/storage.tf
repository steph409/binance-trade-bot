terraform {
  backend "gcs" {
    bucket  = "finance_terraform"
    prefix  = "terraform/state"
  }
}

data "google_project" "default" {
  project_id = "finance-322907"
}

