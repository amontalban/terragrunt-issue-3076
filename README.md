# issue-3076

This repo is used as a reproduceable test case for issue https://github.com/gruntwork-io/terragrunt/issues/3076.

# Requirements

It is recommended that you have the following tools installed:

- Docker
- Docker-compose
- asdf

# Setup

1. Clone this repo
2. Run `asdf install` to install the correct Terraform and Terragrunt versions

# Running the test

There are two cases for the test, one to run multiple jobs in parallel (To replicate what Atlatnis does) and one to run them sequentially.

For parallel execution run: `make parallel`

For sequentially execution run: `make sequential`

Note: All resources (Cache, Localstack volume, etc) will be contained where you checkout this repository.

# Cleaning up

To clean up the resources created by the test run: `make clean`
