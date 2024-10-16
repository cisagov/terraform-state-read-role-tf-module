# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "role_name" {
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows access to the specified state in the S3 bucket where Terraform state is stored."
  nullable    = false
  type        = string
}

variable "terraform_state_bucket_name" {
  description = "The name of the S3 bucket where Terraform state is stored (e.g. example-terraform-state-bucket)."
  nullable    = false
  type        = string
}

variable "terraform_state_path" {
  description = "The path to the Terraform state key(s) in the S3 bucket that the role will be allowed to access (e.g. example-terraform-project/*)."
  nullable    = false
  type        = string
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "account_ids" {
  default     = []
  description = "AWS account IDs that are allowed to assume the role that allows access to the specified Terraform state."
  nullable    = false
  type        = list(string)
}

variable "additional_read_only_states" {
  default     = {}
  description = "A map.  The keys are the state paths and the values are objects where only the key \"workspace\" is supported, and this key is required.  Together the key and value define an additional workspace-specific state to which the user should be granted read-only access.  E.g., {cool-accounts/dynamic.tfstate = {workspace = env6-staging}}."
  nullable    = false
  type        = map(object({ workspace = string }))
}

variable "additional_read_only_states_role_description" {
  default     = "Allows read-only access to additional Terraform states in the %s S3 bucket."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to any additional states in the specified S3 bucket where Terraform state is stored.  The \"%s\" will get replaced with the terraform_state_bucket_name variable.  Note that these additional states (if any) are defined in additional_read_only_states; hence, this variable is not used if additional_read_only_states is an empty map."
  nullable    = false
  type        = string
}

variable "additional_read_only_states_role_name" {
  default     = null
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows access to any additional, read-only states in the S3 bucket where Terraform state is stored.  Note that these additional states (if any) are defined in additional_read_only_states; hence, this variable is not used if additional_read_only_states is an empty map.  If additional_read_only_states is non-empty then thisd variable is required."
  nullable    = true
  type        = string
}

variable "additional_role_tags" {
  default     = {}
  description = "Tags to apply to the IAM role that allows access to the specified Terraform state, in addition to the provider's default tags."
  nullable    = false
  type        = map(string)
}

variable "assume_role_policy_description" {
  default     = "Allow assumption of the %s role in the %s account."
  description = "The description to associate with the IAM policy that allows assumption of the role that allows access to the specified Terraform state.  Note that the first \"%s\" in this value will get replaced with the role_name variable and the second \"%s\" will get replaced with the terraform_account_name variable.  Not used if create_assume_role is false."
  nullable    = false
  type        = string
}

variable "assume_role_policy_name" {
  default     = "Assume%s"
  description = "The name to assign the IAM policy that allows assumption of the role that allows access to the specified Terraform state.  Note that the \"%s\" in this value will get replaced with the role_name variable.  Not used if create_assume_role is false."
  nullable    = false
  type        = string
}

variable "create_assume_role" {
  default     = true
  description = "A boolean value indicating whether or not to create the assume role policy.  In some cases users may want to handle the role delegation in a different way."
  nullable    = false
  type        = bool
}

variable "iam_usernames" {
  default     = ["root"]
  description = "The list of IAM usernames allowed to assume the role that allows access to the specified Terraform state.  If not provided, defaults to allowing any user in the specified account(s).  Note that including \"root\" in this list will override any other usernames in the list."
  nullable    = false
  type        = list(string)
}

variable "lock_db_policy_description" {
  default     = "Allows access to the Terraform locking database for the '%s' workspace(s)."
  description = "The description to associate with the IAM policy that allows access to the Terraform locking database.  Note that the first (and only) \"%s\" will get replaced with the terraform_workspace variable.  This variable is only used if read_only is false."
  nullable    = false
  type        = string
}

variable "lock_db_policy_name" {
  default     = null
  description = "The name to assign the IAM policy that allows access to the DynamoDB state locking table.  This variable is only used if read_only is false, and in that case it is required."
  nullable    = true
  type        = string
}

variable "lock_db_table_arn" {
  default     = null
  description = "The ARN corresponding to the DynamoDB state locking table.  This variable is only used if read_only is false, and in that case it is required."
  nullable    = true
  type        = string
}

variable "read_only" {
  default     = true
  description = "A Boolean value indicating whether or not to make the role and policy read-only.  If false then the role and policy will allow write permissions."
  nullable    = false
  type        = bool
}

variable "role_description" {
  default     = "Allows %s access to the Terraform state at '%s' for the '%s' workspace(s) in the %s S3 bucket."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows access to the specified state in the specified S3 bucket where Terraform state is stored.  Note that the first \"%s\" in this value will get replaced by \"read-only\" if read_only is true and \"read-write\" otherwise, the second \"%s\" will get replaced with the terraform_state_path variable, the third \"%s\" will get replaced with the terraform_workspace variable, and the fourth \"%s\" will get replaced with the terraform_state_bucket_name variable."
  nullable    = false
  type        = string
}

variable "terraform_account_name" {
  default     = "Terraform"
  description = "The name of the account containing the S3 bucket where Terraform state is stored."
  nullable    = false
  type        = string
}

variable "terraform_workspace" {
  default     = "*"
  description = "The name of the workspace containing the Terraform state that the role will be allowed to access.  Defaults to all workspaces ('*')."
  nullable    = false
  type        = string
}
