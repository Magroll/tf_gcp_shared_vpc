provider "google" {
  credentials = file(var.credentials_file[var.project])

  project = var.project
  region  = var.region
  zone    = var.zone
}

# tbd: Enable Cloud Ressource Manager API
# Manual Step via GCloud Shell
# gcloud organizations add-iam-policy-binding "893481264700" \
#   --member="serviceAccount:terraform@tf-test-4711.iam.gserviceaccount.com" \
#   --role="roles/compute.xpnAdmin"
#------------------------------------------------------------------------------
# How to implement in Terraform?
#resource "google_organization_iam_binding" "binding" {
#  org_id = "893481264700"
#  role    = "roles/compute.xpnAdmin"
#
#  members = [
#    "user:terraform@tf-test-4711.iam.gserviceaccount.com",
#  ]
#}
# -- Error: Error retrieving IAM policy for organization "893481264700": googleapi: Error 403: The caller does not have permission, forbidden --


# Wurde durch Modul network ersetzt
#-----------------------------------
#resource "google_compute_network" "tf_network" {
#  name          = "tf-test-network"
#  description   = "Dieses Subnet wurde mit Terraform erstellt!"
#  auto_create_subnetworks = false
#}

#resource "google_compute_subnetwork" "tf_subnetwork" {
#  name          = "tf-test-subnet"
#  ip_cidr_range = "192.168.180.0/24"
#  region        = "europe-west3"
#  network       = "${google_compute_network.tf_network.self_link}"
#}

module "network" {
  source  = "terraform-google-modules/network/google"
  version = "1.1.0"

  network_name    = "tf-vpc-network"
  project_id      = var.project
  shared_vpc_host = "true"

  subnets = [
    {
      subnet_name   = var.host_subnet_name
      subnet_ip     = var.host_subnet_cidr
      subnet_region = var.region
    },
    {
      subnet_name   = var.client_subnet_names[0]
      subnet_ip     = var.client_subnet_cidrs[0]
      subnet_region = var.region
    },
    {
      subnet_name   = var.client_subnet_names[1]
      subnet_ip     = var.client_subnet_cidrs[1]
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    (var.host_subnet_name) = []
    (var.client_subnet_names[0]) = []
    (var.client_subnet_names[1]) = []
  }
}

# A host project provides network resources to associated service projects.
#resource "google_compute_shared_vpc_host_project" "host" {
#  project = var.project
#}

# A service project gains access to network resources provided by its associated host project.
#resource "google_compute_shared_vpc_service_project" "service1" {
#  host_project    = "${google_compute_shared_vpc_host_project.host.project}"
#  service_project = "service-project-id-1"
#}
#resource "google_compute_shared_vpc_service_project" "service2" {
#  host_project    = "${google_compute_shared_vpc_host_project.host.project}"
#  service_project = "service-project-id-2"
#}