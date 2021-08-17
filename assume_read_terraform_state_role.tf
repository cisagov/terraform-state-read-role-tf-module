# IAM policy document that allows assumption of the role in the Terraform
# account that allows read-only access to the specified Terraform state.
data "aws_iam_policy_document" "assume_read_terraform_state_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      module.read_terraform_state.role.arn,
    ]
  }
}

resource "aws_iam_policy" "assume_read_terraform_state_role" {
  count    = var.create_assume_role ? 1 : 0
  provider = aws.users

  description = local.assume_role_policy_description
  name        = local.assume_role_policy_name
  policy      = data.aws_iam_policy_document.assume_read_terraform_state_doc.json
}
