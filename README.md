# Terraform AWS Infrastructure

## Project Overview

This project provisions a highly available AWS infrastructure using Terraform. The infrastructure is modular, reusable, and supports multiple environments (Development and Production). It follows Terraform best practices such as remote state management, state locking, environment separation, reusable modules, and variable parameterization.

---

# Architecture

The infrastructure consists of the following components:

```
                       Internet
                           |
                    Internet Gateway
                           |
                 Public Route Table
                           |
        +------------------+------------------+
        |                                     |
 Public Subnet (AZ-1)                Public Subnet (AZ-2)
        |                                     |
        +------------- Application Load Balancer ------------+
                              |
                     Target Group
                              |
          Auto Scaling Group (EC2 Instances)
                 |                      |
     Private Subnet (AZ-1)    Private Subnet (AZ-2)
                 |
             NAT Gateway
                 |
          Private Route Table
                 |
                VPC
```

---

# Repository Structure

```
terraform-aws-infra/
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── security-group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── alb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── autoscaling/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── environments/
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── provider.tf
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   │
│   └── prod/
│       ├── backend.tf
│       ├── provider.tf
│       ├── main.tf
│       ├── terraform.tfvars
│       └── variables.tf
│
├── .github/
│   └── workflows/
│       └── terraform.yml
│
├── README.md
└── .gitignore
```

---

# Modules

## VPC Module

Creates:

- VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables

---

## Security Group Module

Creates:

- ALB Security Group
- EC2 Security Group

---

## ALB Module

Creates:

- Application Load Balancer
- Target Group
- Listener

---

## EC2 Module

Creates:

- Launch Template
- EC2 Configuration

---

## Auto Scaling Module

Creates:

- Auto Scaling Group
- Scaling Policies

---

# Environments

The project contains two independent environments.

## Development

Lower instance sizes.

Example:

```
instance_type = "t2.micro"
desired_capacity = 2
```

---

## Production

Higher capacity.

Example:

```
instance_type = "t3.medium"
desired_capacity = 4
```

Only the variable values change; the Terraform modules remain the same.

---

# Remote Backend

Terraform state is stored remotely in an S3 bucket.

State locking is provided using DynamoDB.

Example backend configuration:

```
S3 Bucket
    |
terraform.tfstate
    |
DynamoDB Table
(State Lock)
```

Benefits:

- Shared state
- Prevents concurrent modifications
- Versioning support
- Secure storage

---

# CI/CD

GitHub Actions workflow performs:

- terraform fmt
- terraform init
- terraform validate
- terraform plan

The generated Terraform plan is attached to Pull Requests for review before merging.

---

# Security Best Practices

- No AWS credentials stored in the repository.
- Secrets are never committed.
- Sensitive values are passed using environment variables or GitHub Secrets.
- Terraform state file is stored remotely.
- `.terraform/` directory is ignored.
- `terraform.tfstate` files are ignored.

---

# Variables

Environment-specific values are stored in:

```
terraform.tfvars
```

Examples include:

- Region
- Instance type
- Desired capacity
- Maximum capacity
- VPC CIDR

---

# Outputs

Terraform outputs include:

- VPC ID
- Public Subnet IDs
- Private Subnet IDs
- Load Balancer DNS Name
- Auto Scaling Group Name

---

# Deployment Flow

```
Developer

     │

terraform init

     │

terraform plan

     │

Review Changes

     │

terraform apply

     │

AWS Infrastructure Created
```

---

# Terraform Commands

Initialize Terraform

```
terraform init
```

Format code

```
terraform fmt
```

Validate configuration

```
terraform validate
```

Generate execution plan

```
terraform plan
```

Apply infrastructure

```
terraform apply
```

Destroy infrastructure

```
terraform destroy
```

---

# State Management

The following files should **not** be committed to Git:

```
terraform.tfstate
terraform.tfstate.backup
.terraform/
*.tfplan
```

These are excluded using `.gitignore`.

---

# Features

- Modular architecture
- Multi-environment support
- Remote backend with S3
- DynamoDB state locking
- Application Load Balancer
- Private EC2 instances
- Auto Scaling Group
- GitHub Actions CI/CD
- Parameterized configuration
- Secure secret management
- Reusable Terraform modules

---

# Author

Terraform AWS Infrastructure for DevOps Assessment.
