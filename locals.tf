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

  # Create a list of paths in the S3 bucket that our role is allowed to read.
  bucket_paths_allowed_to_read = concat(
    # If the "default" workspace (or "*" for all workspaces) is specified,
    # include the path where Terraform stores default workspace state.
    contains(["*", "default"], var.terraform_workspace) ? [var.terraform_state_path] : [],
    # For non-"default" workspaces, include the correct bucket path.
    var.terraform_workspace != "default" ? ["env:/${var.terraform_workspace}/${var.terraform_state_path}"] : [],
  )

  # If var.role_description contains four instances of "%s", use
  # format() to replace the first "%s" with "read-only" if read_only
  # is true and "read-write" otherwise, the second "%s" with
  # var.terraform_state_path, the third "%s" with
  # var.terraform_workspace, and the fourth "%s" with
  # var.terraform_state_bucket_name.  Otherwise just use
  # var.role_description as is.
  role_description = length(regexall(".*%s.*%s.*%s.*%s.*", var.role_description)) > 0 ? format(var.role_description, var.read_only ? "read-only" : "read-write", var.terraform_state_path, var.terraform_workspace, var.terraform_state_bucket_name) : var.role_description

  # If var.lock_db_policy_description contains two instances of "%s",
  # use format() to replace the first "%s" with
  # var.terraform_state_path, and the second "%s" with
  # var.terraform_workspace.  Otherwise just use
  # var.lock_db_policy_description as is.
  lock_db_policy_description = length(regexall(".*%s.*%s.*", var.lock_db_policy_description)) > 0 ? format(var.lock_db_policy_description, var.terraform_state_path, var.terraform_workspace) : var.lock_db_policy_description
}
