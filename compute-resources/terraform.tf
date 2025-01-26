provider "aws" {
  region = var.region

  default_tags {
    tags = {
      description = "k8s-cluster-manual-setup"
      Environment = "Dev"
    }
  }
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50"
    }
  }

  #required_version = ">= 5"
}
