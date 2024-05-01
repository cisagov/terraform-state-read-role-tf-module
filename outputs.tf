output "assume_policy" {
  description = "An array that is either empty (if no assume role policy was created) or contains a single element that is the policy allowing assumption of the role that can read the specified Terraform state."
  value       = aws_iam_policy.assume_read_terraform_state_role
}

output "policy" {
  description = "The policy that can read the specified Terraform state."
  value       = module.read_terraform_state.policy
}

output "role" {
  description = "The role that can read the specified Terraform state."
  value       = module.read_terraform_state.role
}
