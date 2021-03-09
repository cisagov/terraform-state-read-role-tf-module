# ------------------------------------------------------------------------------
# Create an IAM policy document that allows the specified account(s) to
# assume this role.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_doc" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"
      identifiers = [
        for t in setproduct(var.account_ids, local.iam_usernames) : format("arn:aws:iam::${t[0]}:${t[1]}")
      ]
    }
  }
}
