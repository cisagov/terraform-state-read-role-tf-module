# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "account_ids" {
  description = "AWS account IDs that are allowed to assume the role that allows read-only access to the Terraform state for this example."
  type        = list(string)
}

variable "terraform_state_bucket" {
  description = "The name of the S3 bucket where Terraform state is stored."
  nullable    = false
  type        = string
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------
