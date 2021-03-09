# ------------------------------------------------------------------------------
# Create the IAM role that allows read-only access to the specified state in
# the specified Terraform state bucket.
# ------------------------------------------------------------------------------

resource "aws_iam_role" "read_terraform_state" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_doc.json
  description        = local.role_description
  name               = var.role_name
  tags               = var.role_tags
}

# Attach the IAM policy to the role
resource "aws_iam_role_policy_attachment" "read_terraform_state" {
  policy_arn = aws_iam_policy.read_terraform_state.arn
  role       = aws_iam_role.read_terraform_state.name
}
