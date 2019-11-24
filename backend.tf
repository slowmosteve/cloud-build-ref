terraform {
  backend "gcs" {
    bucket = "tf-backend-259220_state"
    prefix = "/cloud-build-ref/"
  }
}