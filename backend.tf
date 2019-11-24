terraform {
  backend "gcs" {
    bucket = "tf-backend-259220_state"
    prefix = "/tf-ref-project/"
  }
}