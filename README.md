# terraform-state-read-role-tf-module #

[![GitHub Build Status](https://github.com/cisagov/terraform-state-read-role-tf-module/workflows/build/badge.svg)](https://github.com/cisagov/terraform-state-read-role-tf-module/actions)

This is a Terraform module for creating an IAM role and policy that can
read Terraform state objects from a specified S3 bucket.  It also creates
a policy that allows the role to be assumed from a specified list of AWS
account IDs.

## Usage ##

```hcl
module "example" {
  source = "github.com/cisagov/terraform-state-read-role-tf-module"
  providers = {
    aws       = aws
    aws.users = aws.users
  }

  account_ids = ["111111111111"]
  role_name = "ReadTerraformStateReadRoleTFModuleTerraformState"
  terraform_state_bucket_name = "cisa-cool-terraform-state"
  terraform_state_path = "terraform-state-read-role-tf-module/examples/basic_usage/*.tfstate"
}
```

## Examples ##

- [Basic usage](https://github.com/cisagov/terraform-state-read-role-tf-module/tree/develop/examples/basic_usage)

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 4.9 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 4.9 |
| aws.users | ~> 4.9 |

## Modules ##

| Name | Source | Version |
|------|--------|---------|
| read\_terraform\_state | github.com/cisagov/s3-read-role-tf-module | n/a |

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_policy.assume_read_terraform_state_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_document.assume_read_terraform_state_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_ids | AWS account IDs that are allowed to assume the role that allows read-only access to the specified Terraform state. | `list(string)` | `[]` | no |
| additional\_role\_tags | Tags to apply to the IAM role that allows read-only access to the specified Terraform state, in addition to the provider's default tags. | `map(string)` | `{}` | no |
| assume\_role\_policy\_description | The description to associate with the IAM policy that allows assumption of the role that allows read-only access to the specified Terraform state.  Note that the first "%s" in this value will get replaced with the role\_name variable and the second "%s" will get replaced with the terraform\_account\_name variable.  Not used if create\_assume\_role is false. | `string` | `"Allow assumption of the %s role in the %s account."` | no |
| assume\_role\_policy\_name | The name to assign the IAM policy that allows assumption of the role that allows read-only access to the specified Terraform state.  Note that the "%s" in this value will get replaced with the role\_name variable.  Not used if create\_assume\_role is false. | `string` | `"Assume%s"` | no |
| create\_assume\_role | A boolean value indicating whether or not to create the assume role policy.  In some cases users may want to handle the role delegation in a different way. | `bool` | `true` | no |
| iam\_usernames | The list of IAM usernames allowed to assume the role that allows read-only access to the specified Terraform state.  If not provided, defaults to allowing any user in the specified account(s).  Note that including "root" in this list will override any other usernames in the list. | `list(string)` | ```[ "root" ]``` | no |
| read\_only | A Boolean value indicating whether or not to make the role and policy read-only.  If false then the role and policy will allow write permissions. | `bool` | `true` | no |
| role\_description | The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the specified state in the specified S3 bucket where Terraform state is stored.  Note that the first "%s" in this value will get replaced with the terraform\_state\_path variable, the second "%s" will get replaced with the terraform\_workspace variable, and the third "%s" will get replaced with the terraform\_state\_bucket\_name variable. | `string` | `"Allows read-only access to the Terraform state at '%s' for the '%s' workspace(s) in the %s S3 bucket."` | no |
| role\_name | The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the specified state in the S3 bucket where Terraform state is stored. | `string` | n/a | yes |
| terraform\_account\_name | The name of the account containing the S3 bucket where Terraform state is stored. | `string` | `"Terraform"` | no |
| terraform\_state\_bucket\_name | The name of the S3 bucket where Terraform state is stored (e.g. example-terraform-state-bucket). | `string` | n/a | yes |
| terraform\_state\_path | The path to the Terraform state key(s) in the S3 bucket that the role will be allowed to read (e.g. example-terraform-project/*). | `string` | n/a | yes |
| terraform\_workspace | The name of the workspace containing the Terraform state that the role will be allowed to read.  Defaults to all workspaces ('*'). | `string` | `"*"` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| assume\_policy | An array that is either empty (if no assume role policy was created) or contains a single element that is the policy allowing assumption of the role that can read the specified Terraform state. |
| policy | The policy that can read the specified Terraform state. |
| role | The role that can read the specified Terraform state. |
<!-- END_TF_DOCS -->

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, these are the main directory and
every directory under `examples/`.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
