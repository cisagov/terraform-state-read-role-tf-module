# Create an IAM role that can read a Terraform state #

## Usage ##

To run this example, do the following (the steps below use an example
environment named "dev"; replace "dev" with the name of your environment):

1. Create a backend configuration file named `dev.tfconfig` containing the name
of the S3 bucket where "dev" environment Terraform state is stored - this file
is required to initialize the Terraform backend in each environment:

    ```hcl
    bucket = "my-dev-terraform-state-bucket"
    ```

1. Initialize the Terraform backend for the "dev" environment using your backend
   configuration file:

    ```console
    terraform init -upgrade -backend-config=dev.tfconfig
    ```

    > [!NOTE]
    > When performing this step for additional environments (i.e. not your first
    > environment), use the `-reconfigure` flag:
    >
    > ```console
    > terraform init -upgrade -backend-config=other-env.tfconfig -reconfigure
    > ```

1. Create a Terraform variables file named `dev.tfvars` containing the account
  ID(s) that are allowed to assume the Terraform role that will be created and
  the name of the S3 bucket where Terraform state is stored (this should match
  the same bucket name as in the `dev.tfconfig` you created previously). For
  example:

    ```hcl
    account_ids                 = ["111111111111"]
    terraform_state_bucket_name = "my-dev-terraform-state-bucket"
    ```

1. Run `terraform apply -var-file=dev.tfvars` to create the IAM role and
   policies.

Notes:

- This example may create resources which cost money. Run
  `terraform destroy` when you no longer need these resources.
- The default `aws` provider must have permission to create the specified
  IAM policy and role.
- The `aws.users` provider must have permission to create the specified
  IAM policy.

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.1 |
| aws | ~> 4.9 |

## Providers ##

No providers.

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| example | ../../ | n/a |

## Resources ##

No resources.

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_ids | AWS account IDs that are allowed to assume the role that allows read-only access to the Terraform state for this example. | `list(string)` | n/a | yes |
| terraform\_state\_bucket | The name of the S3 bucket where Terraform state is stored. | `string` | n/a | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| assume\_policy | The policy allowing assumption of the role that can read the Terraform state for this example. |
| policy | The policy that can read the Terraform state for this example. |
| role | The role that can read the Terraform state for this example. |
<!-- END_TF_DOCS -->
