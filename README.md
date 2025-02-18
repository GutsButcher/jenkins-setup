# Jenkins Server Automation

Automated Jenkins server deployment using Terraform for infrastructure provisioning and Ansible for configuration management. This project provides a streamlined approach to setting up a fully configured Jenkins server on AWS with necessary plugins and security configurations.

## Project Structure

```
.
├── README.md                 # Main documentation
├── ansible/                  # Ansible configuration
│   ├── ansible.cfg          # Generated by Terraform
│   ├── host_vars/           # Generated by Terraform
│   ├── inventory            # Generated by Terraform
│   ├── playbook.yml         # Main Ansible playbook
│   └── roles/               # Ansible roles
│       └── jenkins_plugins  # Plugin installation role
└── terraform/               # Terraform configuration
    ├── key/                 # SSH keys (generated)
    ├── main.tf              # Main Terraform configuration
    ├── terraform.tf         # Terraform settings
    └── variables.tf         # Variable definitions
```

## Prerequisites

- AWS Account with appropriate permissions
- Terraform >= 1.0.0
- Ansible >= 2.9
- Ubuntu-compatible environment
- AWS CLI configured with necessary credentials

## Quick Start

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd jenkins-setup
   ```

2. Initialize and apply Terraform:
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```

3. Run Ansible playbook:
   ```bash
   cd ../ansible
   ansible-playbook playbook.yml
   ```

4. Access Jenkins:
   - Navigate to `http://<server-ip>:8080`
   - Retrieve the initial admin password from the server
   - Complete the setup wizard

## Documentation

- [Terraform Setup Guide](terraform/tf-setup.md)
- [Ansible Setup Guide](ansible/ansible-setup.md)

## Security Configuration

The security group is configured with the following rules:

### Inbound Rules
- SSH (port 22): Allow remote access
- Jenkins Web Interface (port 8080): Allow web access
- ICMP: Allow ping for network diagnostics

### Outbound Rules
- All traffic: Allow all outbound connections

Additional security features:
- SSH key pairs are automatically generated with 4096-bit RSA
- Keys are stored locally with correct permissions (0600)
- Jenkins is installed with default security settings
- For production use, consider restricting IP ranges in security group rules


##################################################################
##################################################################
##################################################################
##################################################################

# Jenkins Server Automation

Automated Jenkins server deployment using Terraform for infrastructure provisioning and Ansible for configuration management. This project provides a streamlined approach to setting up a fully configured Jenkins server on AWS with necessary plugins and security configurations.

## Project Structure

```
.
├── README.md                 # Main documentation
├── ansible/                  # Ansible configuration
│   ├── ansible.cfg          # Generated by Terraform
│   ├── host_vars/           # Generated by Terraform
│   ├── inventory            # Generated by Terraform
│   ├── playbook.yml         # Main Ansible playbook
│   └── roles/               # Ansible roles
│       └── jenkins_plugins  # Plugin installation role
└── terraform/               # Terraform configuration
    ├── key/                 # SSH keys (generated)
    ├── main.tf              # Main Terraform configuration
    ├── terraform.tf         # Terraform settings
    └── variables.tf         # Variable definitions
```

## Prerequisites

- AWS Account with appropriate permissions
- Terraform >= 1.0.0
- Ansible >= 2.9
- Ubuntu-compatible environment

### AWS Credentials Setup

Export your AWS credentials:
```bash
export AWS_ACCESS_KEY_ID=<your-access-key>
export AWS_SECRET_ACCESS_KEY=<your-secret-access-key>
```

Alternatively, you can configure AWS CLI:
```bash
aws configure
```

## Quick Start

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd jenkins-setup
   ```

2. Initialize and apply Terraform:
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```

3. Run Ansible playbook:
   ```bash
   cd ../ansible
   ansible-playbook playbook.yml
   ```

4. Access Jenkins:
   - Navigate to `http://<server-ip>:8080`
   - Retrieve the initial admin password from the server
   - Complete the setup wizard

## Documentation

- [Terraform Setup Guide](terraform/tf-setup.md)
- [Ansible Setup Guide](ansible/ansible-setup.md)

## Security Configuration

The security group is configured with the following rules:

### Inbound Rules
- SSH (port 22): Allow remote access
- Jenkins Web Interface (port 8080): Allow web access
- ICMP: Allow ping for network diagnostics

### Outbound Rules
- All traffic: Allow all outbound connections

Additional security features:
- SSH key pairs are automatically generated with 4096-bit RSA
- Keys are stored locally with correct permissions (0600)
- Jenkins is installed with default security settings
- For production use, consider restricting IP ranges in security group rules