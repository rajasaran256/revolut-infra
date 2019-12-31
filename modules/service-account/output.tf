output "service_accounts" {
  value       = google_service_account.service_accounts.email
  description = "service account email ID"
}

output "roles" {
  value       = google_project_iam_member.project_roles.role
  description = "Roles granted for the service account"
}
