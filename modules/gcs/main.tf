
# ------------------------------------------------------------------------------
# CREATING A RANDOM INTEGER
# ------------------------------------------------------------------------------
resource "random_integer" "id" {
  min = 111111
  max = 999999
}

# ------------------------------------------------------------------------------
# CREATING A GCS BUCKET
# ------------------------------------------------------------------------------

resource "google_storage_bucket" "image_store" {
  name          = "${var.name}-${random_integer.id.result}"
  project       = var.project
  storage_class = var.storage_class
  location      = "EU"
  force_destroy = true
  versioning {
    enabled = true
  }
}
