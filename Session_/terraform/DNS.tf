resource "google_dns_managed_zone" "private-zone-backend" {
  name        = "private-zone"
  dns_name    = "private.evac.sdu."
  description = "DNS for backend part of Evac app"
  labels = {
    backend = "backend"
  }

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.main.id
    }
    gke_clusters {
      gke_cluster_name = google_container_cluster.primary.id
    }
  }
}
resource "google_dns_record_set" "backend" {
  name = "backend.${google_dns_managed_zone.private-zone-backend.dns_name}"
  type = "A"
  ttl  = 300
  managed_zone = google_dns_managed_zone.private-zone-backend.name

  rrdatas = ["10.0.0.24"]
}