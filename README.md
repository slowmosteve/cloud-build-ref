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

## Setup Cloud Build
- Go to https://console.cloud.google.com/cloud-build/settings and copy the service account for Cloud Build
- This service account needs read and write access to the bucket with Terraform backend state (separate project)
- Shell script `tfstate_config` for granting access using `gsutil`

## Setup Github Deploy Keys
- Shell script for deploy keys
  - `mkdir .ssh`
    - create directory for RSA encryption keys
  - `ssh-keygen -t rsa -b 4096 -C "[replace with email adderess]" -f .ssh/gcp_id_rsa -q -N ""`
    - create new private and public key called "gcp_id_rsa" to be used as GitHub deploy key
  - `gcloud kms keyrings create gcp_github --location=global`
    - create GCP KMS keyring
  - `gcloud kms keys create github-key --location=global --keyring=gcp_github --purpose=encryption`
    - create KMS key
  - `gcloud kms encrypt --plaintext-file=.ssh/gcp_id_rsa --ciphertext-file=gcp_id_rsa.enc --location=global --keyring=gcp_github --key=github-key`
    - encrypt private deploy key and output to "gcp_id_rsa.enc"
  - `gcloud kms keys add-iam-policy-binding github-key --location=global --keyring=gcp_github --member=serviceAccount:[replace with service account] --role=roles/cloudkms.cryptoKeyDecrypter`
    - add decrypter IAM role to cloudbuild service account 
  - `ssh-keyscan -t rsa github.com > known_hosts`
    - add key to known hosts file
- In GitHub repo, add public key `gcp_id_rsa.pub` to the deploy keys with read only access

## Setup Cloud Build
- Update `cloudbuild.yaml` with GitHub repo
- Test the build pipeline using `gcloud builds submit --config=cloudbuild/cloudbuild.yaml .`
