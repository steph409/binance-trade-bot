resource "google_project_service" "container_registry" {
  project = data.google_project.default.id
  service = "containerregistry.googleapis.com"
}


resource "google_compute_address" "static_ip" {
  name = "static-ip-address"
  project = data.google_project.default.number
  region = "europe-west1"
}

resource "google_compute_instance" "binance_bot" {
  name = "binance-bot"
  machine_type = "e2-micro"
  zone = "europe-west1-b"
  project = data.google_project.default.number


  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }
  service_account {
    email  = google_service_account.binance_sa.email
    scopes = ["cloud-platform"]
  }
}