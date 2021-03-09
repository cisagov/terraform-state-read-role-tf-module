# ------------------------------------------------------------------------------
# Create the IAM policy that allows read-only access to the specified
# Terraform state in the S3 bucket where Terraform remote state is stored.
# This is useful for cases when read-only access to a particular state is
# needed, but read-only access to other Terraform states in the bucket is not.
# ------------------------------------------------------------------------------

# IAM policy document that allows read-only access to the specified state
# in the Terraform state bucket.
data "aws_iam_policy_document" "read_terraform_state" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::${var.terraform_state_bucket_name}",
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${var.terraform_state_bucket_name}/env:/${var.terraform_workspace}/${var.terraform_state_path}",
      # If the "default" workspace (or "*" for all workspaces) is specified,
      # include the path where Terraform stores default workspace state.
      contains(["*", "default"], var.terraform_workspace) ? "arn:aws:s3:::${var.terraform_state_bucket_name}/${var.terraform_state_path}" : "",
    ]
  }
}

# IAM policy for read-only access to the specified Terraform state
resource "aws_iam_policy" "read_terraform_state" {
  description = local.role_description
  name        = var.role_name
  policy      = data.aws_iam_policy_document.read_terraform_state.json
}
