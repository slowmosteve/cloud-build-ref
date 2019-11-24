variable "project_id" {
  default     = "cb-ref-project"
  description = "Cloud Build reference project defined by Terraform"
}

variable "enabled_api" {
  description = "The list of enabled APIs for this project"
  type        = list(string)
  default = [
    "cloudbuild.googleapis.com",
    "cloudkms.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "storagetransfer.googleapis.com"
  ]
}