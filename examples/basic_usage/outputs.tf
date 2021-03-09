output "assume_policy" {
  value       = module.example.assume_policy
  description = "The policy allowing assumption of the role that can read the  Terraform state for this example."
}

output "policy" {
  value       = module.example.policy
  description = "The policy that can read the Terraform state for this example."
}

output "role" {
  value       = module.example.role
  description = "The role that can read the Terraform state for this example."
}
