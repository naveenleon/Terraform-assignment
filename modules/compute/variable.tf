variable "vpc_id" {}

variable "public_subnet_id" {}

variable "private_subnet_id" {}

variable "desired_capacity" {}

variable "max_size" {}

variable "min_size" {}

# S3 Variables
variable "dev_bucket_name" {
  type        = string
  default     = "mycompany-app-data-dev"
}

variable "prod_bucket_name" {
  type        = string
  default     = "mycompany-app-data-prod"
}

variable "dev_environment" {
  type    = string
  default = "dev"
}

variable "prod_environment" {
  type    = string
  default = "prod"
}

# EKS Variables
variable "eks_source" {
  type    = string
  default = "git::https://github.com"
}

variable "cluster_name" {
  type    = string
  default = "application-cluster"
}

variable "node_count" {
  type    = number
  default = 3
}

# Aurora Variables
variable "db_name" {
  type    = string
  default = "test-aurora-db-postgres96"
}

variable "engine" {
  type    = string
  default = "aurora-postgresql"
}

variable "engine_version" {
  type    = string
  default = "17.5"
}

variable "cluster_instance_class" {
  type    = string
  default = "db.r8g.large"
}

variable "vpc_id" {
  type    = string
  default = "vpc-12345678"
}

variable "db_subnet_group_name" {
  type    = string
  default = "db-subnet-group"
}

variable "security_group_id" {
  type    = string
  default = "sg-12345678"
}

variable "cidr_ipv4" {
  type    = string
  default = "10.20.0.0/20"
}

variable "storage_encrypted" {
  type    = bool
  default = true
}

variable "apply_immediately" {
  type    = bool
  default = true
}

variable "monitoring_interval" {
  type    = number
  default = 10
}

variable "enabled_cloudwatch_logs_exports" {
  type    = list(string)
  default = ["postgresql"]
}

variable "tags" {
  type = map(string)

  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "instances" {
  type = map(object({
    identifier            = optional(string)
    instance_class        = optional(string)
    publicly_accessible   = optional(bool)
    promotion_tier        = optional(number)
  }))

  default = {
    one = {
      instance_class = "db.r8g.2xlarge"
      publicly_accessible = true
    }
    two = {
      identifier     = "static-member-1"
      instance_class = "db.r8g.2xlarge"
    }
    three = {
      identifier     = "excluded-member-1"
      instance_class = "db.r8g.large"
      promotion_tier = 15
    }
  }
}

variable "autoscaling_enabled" {
  type    = bool
  default = true
}

variable "autoscaling_min_capacity" {
  type    = number
  default = 1
}

variable "autoscaling_max_capacity" {
  type    = number
  default = 5
}

