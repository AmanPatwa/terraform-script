module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "group3-vpc-1"
  cidr = "10.0.0.0/24"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.0.32/28", "10.0.0.48/28"]
  public_subnets  = ["10.0.0.0/28", "10.0.0.16/28"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Project = "Mock-Project"
    Terraform = "true"
    Environment = "dev"
  }
}