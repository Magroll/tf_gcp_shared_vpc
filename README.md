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
- **TBD: Service Account need rights to create Shared VPC (Create in Terraform)**
    - Tried https://www.terraform.io/docs/providers/google/r/google_organization_iam_binding.html
    - Got -- Error: Error retrieving IAM policy for organization "893481264700": googleapi: Error 403: The caller does not have permission, forbidden -- because the serviceaccount doesn't have the right to do it
    - Workaround in gcloud shell:
    - gcloud organizations add-iam-policy-binding "ORG-ID" \
       --member="serviceAccount:SA-Name" \
       --role="roles/compute.xpnAdmin"

## Tools used:
- Coded with Visual Studio Code.
