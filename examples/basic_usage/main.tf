# Our primary provider is in the Terraform account
provider "aws" {
  profile = "cool-terraform-provisionaccount"
  region  = "us-east-1"
}

# Provider for the Users account
provider "aws" {
  alias   = "users"
  profile = "cool-users-provisionaccount"
  region  = "us-east-1"
}

#-------------------------------------------------------------------------------
# Configure the example module.
#-------------------------------------------------------------------------------
module "example" {
  source = "../../"
  providers = {
    aws       = aws
    aws.users = aws.users
  }

  account_ids                 = var.account_ids
  role_name                   = "ReadTerraformStateReadRoleTFModuleTerraformState"
  terraform_state_bucket_name = "cisa-cool-terraform-state"
  terraform_state_path        = "terraform-state-read-role-tf-module/examples/basic_usage/*.tfstate"
}
