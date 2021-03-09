# Create an IAM role that can read a Terraform state #

## Usage ##

To run this example, do the following:

- Execute the `terraform init` command to initialize Terraform.
- Create a Terraform variables file (e.g. `example.tfvars`) containing
  the account ID(s) that are allowed to assume the Terraform role that will
  be created:

  ```console
  account_ids = ["111111111111"]
  ```

- Execute the `terraform apply` command to create the IAM role and policies.

Note that this example may create resources which cost money. Run
`terraform destroy` when you no longer need these resources.

## Requirements ##

- The default `aws` provider must have permission to create the specified
  IAM policy and role.
- The `aws.users` provider must have permission to create the specified
  IAM policy.

## Providers ##

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account_ids | AWS account IDs that are allowed to assume the role that allows read-only access to the Terraform state for this example. | `list(string)` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| assume_policy | The policy allowing assumption of the role that can read the  Terraform state for this example. |
| policy | The policy that can read the Terraform state for this example. |
| role | The role that can read the Terraform state for this example. |
