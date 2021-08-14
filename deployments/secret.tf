resource "google_project_service" "secret_manager" {
  project = data.google_project.default.id
  service = "secretmanager.googleapis.com"
}


resource "google_secret_manager_secret" "secret_api_key" {
  secret_id = "binance_api_secret_key"
  project = data.google_project.default.number
  replication {
    automatic = true
  }
  depends_on = [google_project_service.secret_manager]
}

resource "google_secret_manager_secret" "api_key" {
  secret_id = "binance_api_key"
  project = data.google_project.default.number
  replication {
    automatic = true
  }
  depends_on = [google_project_service.secret_manager]
}