
# ------------------------------------------------------------------------------
# CREATING A RANDOM INTEGER
# ------------------------------------------------------------------------------
resource "random_integer" "id" {
  min = 111111
  max = 999999
}


# ------------------------------------------------------------------------------
# CREATING A SERVICE ACCOUNT
# ------------------------------------------------------------------------------

resource "google_service_account" "service_accounts" {
  account_id   = "${var.id}-${random_integer.id.result}"
  display_name = "Terraform"
  project      = var.project
}

# ------------------------------------------------------------------------------
# ASSIGNING ROLES TO THE SERVICE ACCOUNT
# ------------------------------------------------------------------------------

resource "google_project_iam_member" "project_roles" {
  project = var.project
  role    = var.role
  member  = "serviceAccount:${google_service_account.service_accounts.email}"
}
