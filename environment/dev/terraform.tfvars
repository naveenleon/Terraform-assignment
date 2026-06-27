vpc_cidr            = "10.0.0.0/16"
vpc_name            = "dev-vpc"

public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"

public_az           = "ap-south-1a"
private_az          = "ap-south-1b"

desired_capacity    = 1
min_size            = 1
max_size            = 2
