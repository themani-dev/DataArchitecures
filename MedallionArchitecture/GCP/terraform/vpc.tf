resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

#resource "google_vpc_access_connector" "connector" {
#  name          = var.vpc_name             # must match what your CF expects
#  region        = var.region               # same region as your VPC and Cloud Functions
#  network       = google_compute_network.vpc_network.self_link
#  ip_cidr_range = "10.8.0.0/28"            # CIDR block reserved for connector, pick an unused small subnet
#  min_throughput = 200
#  max_throughput = 200                     # Mbps (minimum is 200, adjust as needed)
# depends_on = [google_compute_network.vpc_network]
#}


resource "google_compute_subnetwork" "subnet" {
  name                     = var.subnet_name
  ip_cidr_range            = var.subnet_ip_range
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal-ingress"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "all"
    ports    = []
  }

  source_ranges = ["10.0.0.0/8"]
  direction     = "INGRESS"
  priority      = 65534
}
