# ------------------------------------------------------------------------------
# CREATING A PUBLIC IP ADDRESS
# ------------------------------------------------------------------------------

resource "google_compute_global_address" "default" {
  provider     = google-beta
  project      = var.project
  name         = var.ip_name
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

# ------------------------------------------------------------------------------
# CREATING A BACKEND
# ------------------------------------------------------------------------------
resource "google_compute_backend_service" "default" {
  provider    = google-beta
  project     = var.project
  name        = var.backend_name
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 30
  dynamic "backend" {
    for_each = var.backend_list
    content {
      group = backend.value
    }
  }
  health_checks = [google_compute_http_health_check.default.self_link]
  enable_cdn    = false
}

# ------------------------------------------------------------------------------
# CREATING A HEALTH CHECK FOR THE BACKEND
# ------------------------------------------------------------------------------
resource "google_compute_http_health_check" "default" {
  provider           = google-beta
  name               = "health-check"
  request_path       = "/"
  check_interval_sec = 30
  timeout_sec        = 10
}

# ------------------------------------------------------------------------------
# CREATING A HTTP PROXY
# ------------------------------------------------------------------------------
resource "google_compute_target_http_proxy" "default" {
  provider = google-beta
  name     = "test-proxy"
  url_map  = google_compute_url_map.default.self_link
}

# ------------------------------------------------------------------------------
# CREATING A URL MAP
# ------------------------------------------------------------------------------
resource "google_compute_url_map" "default" {
  provider        = google-beta
  name            = "url-map"
  default_service = google_compute_backend_service.default.self_link

  host_rule {
    hosts        = ["k8s.com"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.default.self_link

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.default.self_link
    }
  }
}


# ------------------------------------------------------------------------------
# CREATING A FORWARDING RULE
# ------------------------------------------------------------------------------
resource "google_compute_global_forwarding_rule" "default" {
  provider              = google-beta
  name                  = "global-rule"
  target                = google_compute_target_http_proxy.default.self_link
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.default.address
}
