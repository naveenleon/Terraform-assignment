vpc_cidr            = "10.1.0.0/16"
vpc_name            = "prod-vpc"

public_subnet_cidr  = "10.1.1.0/24"
private_subnet_cidr = "10.1.2.0/24"

public_az           = "us-east-1a"
private_az          = "us-east-1b"

desired_capacity    = 2
min_size            = 2
max_size            = 4
