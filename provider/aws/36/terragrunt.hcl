locals {
  folder_name  = basename(get_terragrunt_dir())
}

# Include general settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# Include AWS specific settings like backend, provider version, etc
include "aws" {
  path           = find_in_parent_folders("aws.hcl")
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-iam.git//modules/iam-assumable-role?ref=v5.39.0"
}

inputs = {
  create_role    = true
  role_requires_mfa = false
  role_name         = "role-${local.folder_name}"
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess"
  ]
  role_description  = "Testing Terragrunt Cache parallel execution role-${local.folder_name}"
}
