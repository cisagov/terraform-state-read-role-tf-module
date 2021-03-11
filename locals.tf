# ------------------------------------------------------------------------------
# Evaluate expressions for use throughout this configuration.
# ------------------------------------------------------------------------------

locals {
  # If var.assume_role_policy_description contains two instances of "%s", use
  # format() to replace the first "%s" with var.role_name and the second "%s"
  # with var.terraform_account_name.  Otherwise just use
  # var.assume_role_policy_description as is.
  assume_role_policy_description = length(regexall(".*%s.*%s.*", var.assume_role_policy_description)) > 0 ? format(var.assume_role_policy_description, var.role_name, var.terraform_account_name) : var.assume_role_policy_description

  # If var.assume_role_policy_name contains one instance of "%s", use format()
  # to replace the "%s" with var.role_name. Otherwise just use
  # var.assume_role_policy_name as is.
  assume_role_policy_name = length(regexall(".*%s.*", var.assume_role_policy_name)) > 0 ? format(var.assume_role_policy_name, var.role_name) : var.assume_role_policy_name

  # Properly format usernames for use in an ARN
  iam_usernames = contains(var.iam_usernames, "root") ? ["root"] : formatlist("user/%s", var.iam_usernames)
  # Create a list of paths in the S3 bucket that our role is allowed to read.
  bucket_paths_allowed_to_read = concat(
    # If the "default" workspace (or "*" for all workspaces) is specified,
    # include the path where Terraform stores default workspace state.
    contains(["*", "default"], var.terraform_workspace) ? ["${var.terraform_state_path}"] : [],
    # For non-"default" workspaces, include the correct bucket path.
    var.terraform_workspace != "default" ? ["env:/${var.terraform_workspace}/${var.terraform_state_path}"] : [],
  )

  # If var.role_description contains three instances of "%s", use format() to
  # replace the first "%s" with var.terraform_state_path, the second "%s"
  # with var.terraform_workspace, and the third "%s" with
  # var.terraform_state_bucket_name.  Otherwise just use var.role_description
  # as is.
  role_description = length(regexall(".*%s.*%s.*%s.*", var.role_description)) > 0 ? format(var.role_description, var.terraform_state_path, var.terraform_workspace, var.terraform_state_bucket_name) : var.role_description
}
