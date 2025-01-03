# Sales Spoke VPC

This example demonstrates how to provision a spoke VPC and basic networking infrastructure in the `sales` AWS account, to host a sales lead generation application. The example demonstrates how to use the `vpc-spoke-tgw` OpenTofu module to provision the spoke VPC and networking infrastructure across multiple environments. A sandbox (`sbx`) environment is provided as an example.

## Prerequisites

- The TGW is set up in the `network services` AWS account and shared with the `sales` AWS account via Resource Access Manager (RAM). Once done, the `TGW share ARN` will be made available. Ideally, if the TGW share is automated via OpenTofu, then the ARN may be accessed from OpenTofu state. You can still test the module *without the TGW share*, but you must ensure that `tgw_sharing_enabled = false` in the `terraform.tfvars` file. Later, when your Network team shares the TGW, you may update the `tgw_sharing_enabled` variable to `true` and re-run the OpenTofu commands.

- The `sales-spoke-vpc` example uses OpenTofu's **[early variable evaluation](https://opentofu.org/docs/how-to/early-variable-evaluation.html)** feature to configure the remote backend (S3 buckets and DynamoDB tables) in `backend.tf`. In order to create the remote backend for use by OpenTofu to manage state, a bootstrap script is provided in the `bootstrap` directory. This bootstrap script uses a CloudFormation stack (`bootstrap-backend.yml`) to create the S3 bucket and DynamoDB table. Do the following to bootstrap the backend.
  - Navigate to the `bootstrap` directory.
  ```
  cd bootstrap
  ```
  - Run the bootstrap script.
  ```
  ./bootstrap.sh <ENVIRONMENT>
  ```

## Usage

On the machine where you will execute the OpenTofu commands, do the following:
  - [Install OpenTofu](https://opentofu.org/docs/install/index.html)
  - Set environment variables for the `sales` AWS account (credentials for a user with the necessary permissions to create the resources in the VPC).
  ```
  export AWS_ACCESS_KEY_ID="your_access_key"
  export AWS_SECRET_ACCESS_KEY="your_secret_key"
  export AWS_REGION="your_region"
  ```
  - Clone the `terraform-aws-vpc-spoke-tgw` repository.
  ```
  git clone https://github.com/cybergavin/terraform-aws-vpc-spoke-tgw.git
  ```
  - Navigate to the appropriate `environments` directory. In this example, a `sbx` (sandbox) environment is used
  ```
  cd terraform-aws-vpc-spoke-tgw/examples/sales-spoke-vpc/environments/sbx
  ```
  - Update the `terraform.tfvars` file with the required variables (or leave as is, if there's no conflict with the default values).
  - Run the OpenTofu commands.
  ```
  tofu init
  tofu plan
  tofu apply
  ```
  - If you want to destroy the resources, run the following command.
  ```
  tofu destroy
  ```