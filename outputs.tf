output "assume_policy" {
  value       = aws_iam_policy.assume_read_terraform_state_role
  description = "The policy allowing assumption of the role that can read the specified Terraform state."
}

output "policy" {
  value       = module.read_terraform_state.policy
  description = "The policy that can read the specified Terraform state."
}

output "role" {
  value       = module.read_terraform_state.role
  description = "The role that can read the specified Terraform state."
}
