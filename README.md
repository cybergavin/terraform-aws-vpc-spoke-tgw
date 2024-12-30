# OpenTofu Module: `vpc-spoke-tgw`

This OpenTofu module provisions foundational networking infrastructure in **spoke VPCs** that host business applications or workloads. It helps to quickly set up basic networking required by workloads in a multi-account hub-spoke network topology on AWS, where all ingress and egress traffic to/from the workload VPC passes through a *hub* VPC (in another AWS account) via a Transit Gateway (TGW).

## Features
- Provisions the following network infrastructure in a spoke AWS account:
  - A VPC with subnets
  - TGW share acceptance and TGW attachments
  - Route tables with local and TGW-bound routes
  - DHCP options set with custom DNS settings
  - Security Groups for workloads
- Leverages the cloudposse terraform-null-label module to assign standardized names to provisioned resources.
- Applies tags consistently to provisioned resources.

## Prerequisites

- The TGW set up in the `network services` AWS account must be shared with the `workload` AWS account via Resource Access Manager (RAM) and the `TGW share ARN` must be made available. Ideally, if the TGW share is automated via OpenTofu, then the ARN may be accessed from OpenTofu state.
- The `TGW ID` must be made available. Ideally, if the TGW provisioning is automated via OpenTofu, then the TGW ID may be accessed from OpenTofu state.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->