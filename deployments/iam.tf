resource "google_service_account" "binance_sa" {
  account_id   = "binance-bot"
  display_name = "Binance bot sa"
  project = data.google_project.default.project_id
}

resource "google_storage_bucket_iam_binding" "export_database_dumps" {
  members = ["serviceAccount:${google_service_account.binance_sa.email}"]
  role = "roles/storage.admin"
  bucket = google_storage_bucket.database_dumps.name
}

resource "google_compute_instance_iam_binding" "access_vm" {
  members = ["serviceAccount:${google_service_account.binance_sa.email}"]
  role = "roles/compute.admin"
  instance_name = google_compute_instance.binance_bot.name
  project = google_compute_instance.binance_bot.project
  zone = google_compute_instance.binance_bot.zone
}

resource "google_project_iam_member" "get_project" {
  project = data.google_project.default.project_id
  role = "roles/compute.instanceAdmin.v1"
  member = "serviceAccount:${google_service_account.binance_sa.email}"
}

resource "google_service_account_iam_member" "invoker" {
  role = "roles/iam.serviceAccountUser"
  member = "serviceAccount:${google_service_account.binance_sa.email}"
  service_account_id = google_service_account.binance_sa.name
}