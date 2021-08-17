output "assume_policy" {
  value       = aws_iam_policy.assume_read_terraform_state_role
  description = "An array that is either empty (if no assume role policy was created) or contains a single element that is the policy allowing assumption of the role that can read the specified Terraform state."
}

output "policy" {
  value       = module.read_terraform_state.policy
  description = "The policy that can read the specified Terraform state."
}

output "role" {
  value       = module.read_terraform_state.role
  description = "The role that can read the specified Terraform state."
}
