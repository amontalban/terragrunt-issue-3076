locals {
  aws_provider_version = ">= 5.43.0"

  # Set paths to version constraints files
  terraform_version_constraint_path  = fileexists("${get_terragrunt_dir()}/.terraform-version") ? "${get_terragrunt_dir()}/.terraform-version" : find_in_parent_folders(".terraform-version")
  terragrunt_version_constraint_path = fileexists("${get_terragrunt_dir()}/.terragrunt-version") ? "${get_terragrunt_dir()}/.terragrunt-version" : find_in_parent_folders(".terragrunt-version")
}

# Generate an AWS provider block
generate "versions_override" {
  path      = "versions_override.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = "= ${trimspace(file(local.terraform_version_constraint_path))}"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "${local.aws_provider_version}"
    }
  }
}

provider "aws" {
  access_key = "test"
  secret_key = "test"
  region     = "us-east-1"

  endpoints {
    iam            = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
}
EOF
}

