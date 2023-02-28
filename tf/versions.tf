terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.3.1"
    }
  }
  backend "s3" {
    bucket = "vspheredev"
    key    = "terraform.tfstate"

    endpoint = "https://localhost:9000"

    access_key = "minioadmin"
    secret_key = "minioadmin"

    region                      = "main"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
  }
  required_version = ">= 0.13"
}