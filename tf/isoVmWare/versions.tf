terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.2.0"
    }
  }
  backend "s3" {
    bucket = "iso"
    key    = "terraform.tfstate"

    endpoint = "https://localhost:9000"

    access_key = "minioadmin"
    secret_key = "minioadmin"

    region                      = "main"
#    encrypt                     = "AES256"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
  required_version = ">= 0.13"
}
