# This is the "default" provider, which must have access to create the
# necessary IAM resources within the account containing the Terraform S3
# bucket.
provider "aws" {
}

# The provider used to create resources inside the Users account.
provider "aws" {
  alias = "users"
}
