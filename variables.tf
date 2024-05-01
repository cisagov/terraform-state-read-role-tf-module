# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "role_name" {
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the specified state in the S3 bucket where Terraform state is stored."
  type        = string
}

variable "terraform_state_bucket_name" {
  description = "The name of the S3 bucket where Terraform state is stored (e.g. example-terraform-state-bucket)."
  type        = string
}

variable "terraform_state_path" {
  description = "The path to the Terraform state key(s) in the S3 bucket that the role will be allowed to read (e.g. example-terraform-project/*)."
  type        = string
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "account_ids" {
  default     = []
  description = "AWS account IDs that are allowed to assume the role that allows read-only access to the specified Terraform state."
  type        = list(string)
}

variable "additional_role_tags" {
  default     = {}
  description = "Tags to apply to the IAM role that allows read-only access to the specified Terraform state, in addition to the provider's default tags."
  type        = map(string)
}

variable "assume_role_policy_description" {
  default     = "Allow assumption of the %s role in the %s account."
  description = "The description to associate with the IAM policy that allows assumption of the role that allows read-only access to the specified Terraform state.  Note that the first \"%s\" in this value will get replaced with the role_name variable and the second \"%s\" will get replaced with the terraform_account_name variable.  Not used if create_assume_role is false."
  type        = string
}

variable "assume_role_policy_name" {
  default     = "Assume%s"
  description = "The name to assign the IAM policy that allows assumption of the role that allows read-only access to the specified Terraform state.  Note that the \"%s\" in this value will get replaced with the role_name variable.  Not used if create_assume_role is false."
  type        = string
}

variable "create_assume_role" {
  default     = true
  description = "A boolean value indicating whether or not to create the assume role policy.  In some cases users may want to handle the role delegation in a different way."
  type        = bool
}

variable "iam_usernames" {
  default     = ["root"]
  description = "The list of IAM usernames allowed to assume the role that allows read-only access to the specified Terraform state.  If not provided, defaults to allowing any user in the specified account(s).  Note that including \"root\" in this list will override any other usernames in the list."
  type        = list(string)
}

variable "role_description" {
  default     = "Allows read-only access to the Terraform state at '%s' for the '%s' workspace(s) in the %s S3 bucket."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the specified state in the specified S3 bucket where Terraform state is stored.  Note that the first \"%s\" in this value will get replaced with the terraform_state_path variable, the second \"%s\" will get replaced with the terraform_workspace variable, and the third \"%s\" will get replaced with the terraform_state_bucket_name variable."
  type        = string
}

variable "terraform_account_name" {
  default     = "Terraform"
  description = "The name of the account containing the S3 bucket where Terraform state is stored."
  type        = string
}

variable "terraform_workspace" {
  default     = "*"
  description = "The name of the workspace containing the Terraform state that the role will be allowed to read.  Defaults to all workspaces ('*')."
  type        = string
}
