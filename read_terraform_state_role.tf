# ------------------------------------------------------------------------------
# Create the IAM role and policy that allows read-only access to the
# specified state in the specified Terraform state bucket.
# ------------------------------------------------------------------------------

module "read_terraform_state" {
  source = "github.com/cisagov/s3-read-role-tf-module"
  providers = {
    aws = aws
  }

  account_ids      = var.account_ids
  entity_name      = var.role_name
  iam_usernames    = var.iam_usernames
  role_description = local.role_description
  role_name        = var.role_name
  role_tags        = var.role_tags
  s3_bucket        = var.terraform_state_bucket_name
  s3_objects       = local.bucket_paths_allowed_to_read
}
