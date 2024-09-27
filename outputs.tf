output "assume_policy" {
  description = "An array that is either empty (if no assume role policy was created) or contains a single element that is the policy allowing assumption of the role that can access the specified Terraform state."
  value       = aws_iam_policy.assume_read_terraform_state_role
}

output "policy" {
  description = "The policy that can access the specified Terraform state."
  value       = module.read_terraform_state.policy
}

output "read_only" {
  description = "A Boolean value indicating whether or not the role and policy are read-only.  If false then the role and policy will allow write permissions."
  value       = var.read_only
}

output "role" {
  description = "The role that can access the specified Terraform state."
  value       = module.read_terraform_state.role
}
