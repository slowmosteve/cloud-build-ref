# Cloud Build Reference Project

This repo demostrates how to create projects in Google Cloud Platform with remote Terraform state management and builds automated through Google Cloud Build.

## Create Project
- create new project using `gcloud projects create [project id]`
- create a config for this project using `gcloud config configurations create [project id]`
- set up the project using `gcloud init`
- link the project to billing using `gcloud beta billing projects link my-project --billing-account 0X0X0X-0X0X0X-0X0X0X`
  - see billing account using `gcloud beta billing accounts list`
- add the project ID to the `variables.tf` file (or add to TF_ENV variables)
- run `terraform init` to initialize Terraform
- run `terraform apply` to enable APIs

## Enable Remote Terraform State
- Go to https://console.cloud.google.com/cloud-build/settings and copy the service account for Cloud Build
- This service account needs read and write access to the bucket with Terraform backend state (separate project)
- Shell script `tfstate_config` for granting access using `gsutil`
  - Prompts for Cloud Build service account and remote Terraform state bucket

## Setup Github Deploy Keys
- Shell script `deploy_key_init` for creating deploy keys and encrypting with KMS
- In GitHub repo, add public key `gcp_id_rsa.pub` to the deploy keys with read only access

## Grant Project Editor Access to Cloud Build Service Account
- Shell script `iam_config` for adding `

## Update Cloud Build YAML
- Update `cloudbuild.yaml` with GitHub repo
- Test the build pipeline using `gcloud builds submit --config=cloudbuild/cloudbuild.yaml .`

## Setup Cloud Build Trigger
- Shell script `build_config` for creating trigger in Cloud Build (Cloud Build integration with GitHub doesn't work yet)