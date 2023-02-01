terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.2.0"
    }
  }
  backend "s3" {
    bucket = "demo"
    key    = "terraform.tfstate"

    endpoint = "http://127.0.0.1:9000"

    access_key = "wFJPCckVw2sRzurq"
    secret_key = "zr1NAJ4CtRxowNvseKLJug9JrWqfLhk3"

    region                      = "main"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
  }
  required_version = ">= 0.13"
}
