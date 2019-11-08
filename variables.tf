variable "credentials_file" { 
    type = "map"
}

variable "project" {
    type = "string"
 }

variable "region" {
    type = "string"
}

variable "zone" {
    type = "string"
}

variable "host_subnet_name" {
    type = "string"  
}

variable "host_subnet_cidr" {
    type = "string"  
}

variable "client_subnet_names" {
    type = "list"  
}

variable "client_subnet_cidrs" {
    type = "list"  
}