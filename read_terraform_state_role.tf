# ------------------------------------------------------------------------------
# Create the IAM role and policy that allows read-only access to the
# specified state in the specified Terraform state bucket.
# ------------------------------------------------------------------------------

module "read_terraform_state" {
  source = "github.com/cisagov/s3-read-role-tf-module"
  providers = {
    aws = aws
  }

  account_ids          = var.account_ids
  additional_role_tags = var.additional_role_tags
  entity_name          = var.role_name
  iam_usernames        = var.iam_usernames
  read_only            = var.read_only
  role_description     = local.role_description
  role_name            = var.role_name
  s3_bucket            = var.terraform_state_bucket_name
  s3_objects           = local.bucket_paths_allowed_to_read
}

# IAM policy document that allows sufficient access to the state
# locking table to use that resource in a Terraform backend.
data "aws_iam_policy_document" "access_terraform_lock_db_doc" {
  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
    ]
    condition {
      test     = "ForAnyValue:StringEquals"
      values   = flatten([for path in local.bucket_paths_allowed_to_read : ["${var.terraform_state_bucket_name}/${path}", "${var.terraform_state_bucket_name}/${path}-md5"]])
      variable = "dynamodb:LeadingKeys"
    }
    resources = [
      "arn:aws:dynamodb:us-east-1:210193616405:table/terraform-state-lock",
    ]
  }
}

# The IAM policy that allows sufficient access to the state
# locking table to use that resource in a Terraform backend.
resource "aws_iam_policy" "access_terraform_lock_db_policy" {
  count = var.read_only ? 0 : 1

  description = local.lock_db_policy_description
  name        = var.lock_db_policy_name
  policy      = data.aws_iam_policy_document.access_terraform_lock_db_doc.json
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "access_terraform_lock_db_policy_attachment" {
  count = var.read_only ? 0 : 1

  policy_arn = aws_iam_policy.access_terraform_lock_db_policy[0].arn
  role       = module.read_terraform_state.role.name
}
