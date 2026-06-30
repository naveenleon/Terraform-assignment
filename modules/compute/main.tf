resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ec2_sg" {
  name   = "ec2-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "alb" {
  name               = "main-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]

  subnets = [
    var.public_subnet_id
  ]
}

resource "aws_lb_target_group" "tg" {
  name     = "main-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_launch_template" "lt" {
  name_prefix   = "web-template"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Hello from Auto Scaling EC2" > /var/www/html/index.html
EOF
  )
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  vpc_zone_identifier = [
    var.private_subnet_id
  ]

  target_group_arns = [
    aws_lb_target_group.tg.arn
  ]

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  health_check_type = "EC2"
}
# root directory main.tf

module "dev_storage" {
  source      = "./modules/s3_bucket"
  bucket_name = "mycompany-app-data-dev"
  environment = "dev"
}

module "prod_storage" {
  source      = "./modules/s3_bucket"
  bucket_name = "mycompany-app-data-prod"
  environment = "prod"
}

# Accessing module outputs in the root level
output "production_bucket_arn" {
  value = module.prod_storage.bucket_arn
}
module "eks_cluster" {
  # HTTPS URL with a specified version tag (?ref=)
  source = "git::https://github.com"

  cluster_name = "application-cluster"
  node_count   = 3
}
module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  name           = "test-aurora-db-postgres96"
  engine         = "aurora-postgresql"
  engine_version = "17.5"

  cluster_instance_class = "db.r8g.large"
  instances = {
    one = {}
    two = {
      instance_class = "db.r8g.2xlarge"
    }
  }

  vpc_id               = "vpc-12345678"
  db_subnet_group_name = "db-subnet-group"
  security_group_ingress_rules = {
    ex1_ingress = {
      cidr_ipv4 = "10.20.0.0/20"
    }
    ex1_ingress = {
      referenced_security_group_id = "sg-12345678"
    }
  }

  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10

  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
    cluster_instance_class = "db.r8g.large"
    instances = {
      one   = {}
      two   = {}
      three = {}
    }
    cluster_instance_class = "db.r8g.large"
    instances = {
      one   = {}
      two   = {}
      three = {}
    }

    autoscaling_enabled      = true
    autoscaling_min_capacity = 2
    autoscaling_max_capacity = 5

    cluster_instance_class = "db.r8g.large"
    instances = {
      one = {}
    }

    autoscaling_enabled      = true
    autoscaling_min_capacity = 1
    autoscaling_max_capacity = 5

    cluster_instance_class = "db.r8g.large"
    instances = {
      one = {}
    }

    autoscaling_enabled      = true
    autoscaling_min_capacity = 1
    autoscaling_max_capacity = 5

    cluster_instance_class = "db.r8g.large"
    instances = {
      one = {
        instance_class      = "db.r8g.2xlarge"
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
