# Terraform Infrastructure Setup

This guide details the Terraform configuration for provisioning Jenkins infrastructure on AWS.

## Infrastructure Components

- EC2 instance (t2.micro) running Ubuntu 20.04
- Default VPC with custom subnet
- Security group with full access
- SSH key pair for instance access
- Ansible configuration generation

## Configuration Files

### main.tf
Contains the main infrastructure configuration:
- VPC and subnet configuration
- SSH key pair generation
- EC2 instance provisioning
- Security group setup
- Ansible configuration generation

### variables.tf
Defines variables used in the configuration:
```hcl
variable "key_name" {
  description = "The name of the key pair to use for the EC2 instance"
  type        = string
  default     = "jenkins_key"
}
```

### terraform.tf
Specifies Terraform settings and required providers:
```hcl
terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0.0"
    }
  }
}
```

## Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Review planned changes:
   ```bash
   terraform plan
   ```

3. Apply configuration:
   ```bash
   terraform apply
   ```

4. Access outputs:
   ```bash
   terraform output
   ```

## Generated Resources

- SSH key pair in `./key/` directory
- Ansible configuration files:
  - `../ansible/ansible.cfg`:
    ```ini
    [defaults]
    inventory = inventory
    remote_user = ubuntu
    ```
  - `../ansible/inventory`:
    ```ini
    [jenkins]
    <public-ip>
    [jenkins:vars]
    ansible_ssh_user=ubuntu
    ansible_ssh_private_key_file=<absolute-path-to-key>
    ```
  - `../ansible/host_vars/<ip>.yml`

## Important Notes

- The security group allows all traffic (modify for production)
- SSH keys are generated automatically
- Ansible files are created using local-exec provisioner
- Instance uses Ubuntu 20.04 LTS AMI

