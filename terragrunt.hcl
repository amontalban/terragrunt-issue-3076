# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Fix Terraform and Terragrunt versions
terraform_version_constraint  = trimspace(file(local.terraform_version_constraint_path))
terragrunt_version_constraint = trimspace(file(local.terragrunt_version_constraint_path))

locals {
  # Set paths to version constraints files
  terraform_version_constraint_path  = fileexists("${get_terragrunt_dir()}/.terraform-version") ? "${get_terragrunt_dir()}/.terraform-version" : find_in_parent_folders(".terraform-version")
  terragrunt_version_constraint_path = fileexists("${get_terragrunt_dir()}/.terragrunt-version") ? "${get_terragrunt_dir()}/.terragrunt-version" : find_in_parent_folders(".terragrunt-version")
}

# Configure Terragrunt hooks

terraform {
  # Force Terraform to keep trying to acquire a lock for up to 20 minutes if someone else already has the lock
  extra_arguments "retry_lock" {
    commands  = get_terraform_commands_that_need_locking()
    arguments = ["-lock-timeout=20m"]
  }

  # Force Terraform to run with reduced parallelism
  extra_arguments "parallelism" {
    commands  = get_terraform_commands_that_need_parallelism()
    arguments = ["-parallelism=4"]
  }
}
