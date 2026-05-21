# Terraform Infrastructure

This directory contains Terraform code for provisioning a VPC, public and private subnets, NAT gateway, security group, and an EC2 instance in AWS.

## Backend

Terraform state is stored in an S3 bucket and locked using DynamoDB.

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "terraform/state.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
```

## Quick start

Initialize the working directory and download provider plugins:

```bash
cd terraform
terraform init
```

Validate the configuration:

```bash
terraform validate
```

Generate and review an execution plan:

```bash
terraform plan -out=tfplan
```

Apply the plan to create resources:

```bash
terraform apply "tfplan"
```

## Example variable values

Use a `terraform.tfvars` file or environment variables to provide values for the following variables.

```yaml
ami_id: "ami-0123456789abcdef0"
instance_type: "t3.micro"
key_name: "my-ssh-key"
vpc_cidr: "10.0.0.0/16"
public_subnet_cidr: "10.0.1.0/24"
private_subnet_cidr: "10.0.2.0/24"
```

## Notes

- Update the S3 bucket and DynamoDB table names in `backend.tf` before running `terraform init`.
- Ensure the AWS CLI credentials or environment variables are configured for the target AWS account.
- The `ap-south-1` region is currently used in the provider and backend configuration.
