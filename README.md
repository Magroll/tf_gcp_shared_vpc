# tf_gcp_first
- First Terraform Project in GCP
- Based on https://learn.hashicorp.com/terraform/gcp/intro

## Manual Steps:
- Create GCP Account
- Create Project
- Goto IAM & Management / Service Accounts
    - Create new GCP Service Account for Terraform
    - Apply Role "Project -> Editor" to new Service Account
    - Download Key File
    - Store Key in Keys Directory in Projectfolder
- Edit "project" Variable in terraform.tfvars
- Edit "credentials_file" Variable in terraform.tfvars 
- Service Account need rights to create Shared VPC (tbd in Terraform)
    - gcloud organizations add-iam-policy-binding "ORG-ID" \
       --member="serviceAccount:SA-Name" \
       --role="roles/compute.xpnAdmin"

## Tools used:
- Coded with Visual Studio Code.