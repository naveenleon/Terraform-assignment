# Terraform AWS Infrastructure Project

## Overview

This project provisions a secure and scalable AWS infrastructure using Terraform. It follows Infrastructure as Code (IaC) best practices by using reusable modules, remote state management, environment-specific configurations, and parameterized variables.

---

# Architecture

The infrastructure includes:

- VPC
- Public and Private Subnets across two Availability Zones
- Internet Gateway
- NAT Gateway
- Public and Private Route Tables
- Security Groups
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG)
- EC2 Instances in Private Subnets
- Remote Terraform Backend (S3)
- State Locking (DynamoDB)

---

# Project Structure

```
terraform-project/
│
├── modules/
│   ├── vpc/
│   ├── security-group/
│   ├── alb/
│   ├── ec2/
│   └── autoscaling/
│
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   │
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       └── backend.tf
│
├── .gitignore
├── README.md
└── modules
```

---

# Prerequisites

Before running Terraform, install:

- Terraform
- AWS CLI
- Git

Configure AWS credentials:

```
aws configure
```

or use environment variables:

```
export AWS_ACCESS_KEY_ID=<your-access-key>
export AWS_SECRET_ACCESS_KEY=<your-secret-key>
export AWS_DEFAULT_REGION=ap-south-1
```

---

# Initialize Terraform

Move into the required environment.

Example:

```
cd environments/dev
```

Initialize Terraform.

```
terraform init
```

---

# Format Configuration

```
terraform fmt
```

---

# Validate Configuration

```
terraform validate
```

---

# Generate Execution Plan

For Development:

```
terraform plan -var-file="terraform.tfvars"
```

For Production:

```
cd ../prod

terraform plan -var-file="terraform.tfvars"
```

---

# Apply Infrastructure

```
terraform apply -var-file="terraform.tfvars"
```

Type:

```
yes
```

when prompted.

---

# Destroy Infrastructure

```
terraform destroy -var-file="terraform.tfvars"
```

---

# Environment Configuration

The same Terraform modules are shared by both environments.

Only the values inside:

- dev/terraform.tfvars
- prod/terraform.tfvars

are different.

Example:

Development

```
instance_type = "t3.micro"
desired_capacity = 1
```

Production

```
instance_type = "t3.medium"
desired_capacity = 3
```

---

# Remote Backend

Terraform state is stored remotely in an S3 bucket.

State locking is enabled using DynamoDB to prevent concurrent updates.

---

# Security Best Practices

- No AWS credentials are stored in the repository.
- No secrets are hardcoded.
- State files are not committed.
- Sensitive values are managed outside Terraform.
- Security Groups follow the principle of least privilege.

---

# .gitignore

```
.terraform/
*.tfstate
*.tfstate.*
terraform.tfvars
crash.log
```

---

# Sample Terraform Plan

```
Plan: 18 to add, 0 to change, 0 to destroy.
```

---

# Technologies Used

- Terraform
- AWS VPC
- EC2
- Auto Scaling
- Application Load Balancer
- Security Groups
- S3 Backend
- DynamoDB State Locking

---

# Author

Naveen
