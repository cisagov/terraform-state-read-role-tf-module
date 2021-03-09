output "assume_policy" {
  value       = aws_iam_policy.assume_read_terraform_state_role
  description = "The policy allowing assumption of the role that can read the specified Terraform state."
}

output "policy" {
  value       = aws_iam_policy.read_terraform_state
  description = "The policy that can read the specified Terraform state."
}

output "role" {
  value       = aws_iam_role.read_terraform_state
  description = "The role that can read the specified Terraform state."
}
