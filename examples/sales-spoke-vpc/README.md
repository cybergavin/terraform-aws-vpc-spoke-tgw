# Sales Spoke VPC

This example demonstrates how to provision a spoke VPC and basic networking infrastructure in the `sales` AWS account, to host a sales lead generation application. The example demonstrates how to use the `vpc-spoke-tgw` OpenTofu module to provision the spoke VPC and networking infrastructure across multiple environments. A sandbox (`sbx`) environment is provided as an example.

## Prerequisites

- The TGW set up in the `network services` AWS account must be shared with the `sales` AWS account via Resource Access Manager (RAM) and the `TGW share ARN` must be made available. Ideally, if the TGW share is automated via OpenTofu, then the ARN may be accessed from OpenTofu state.
- AWS CLI must be installed and configured with credentials for the `sales` AWS account.
- OpenTofu must be installed.
- The `terraform.tfvars` file must be created in the `environments/sbx` directory.

## Remote Backend Bootstrap

To set up the remote backend (S3 bucket and DynamoDB table) for storing OpenTofu state:

1. Navigate to the bootstrap directory:

```sh
cd bootstrap
```

2. Run the bootstrap script:

```sh
./bootstrap.sh
```

## Example

```hcl
module "sales-spoke-vpc" {
  source  = "cybergavin/vpc-spoke-tgw/aws"
  version = "1.0.0"
  # insert the required variables here
}
```