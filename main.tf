provider "aws" {

  region = "us-east-1"
}


data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

resource "aws_vpc" "vpc" {

  cidr_block = var.vpc_cidr
  tags = {

    Name        = var.vpc_name
    Environment = "demo_enviroment"
    Terraform   = "true"

  }
}


resource "aws_subnet" "private_subnets" {

  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = tolist(data.aws_avaiability_zones.availabite.names)[each.value]

  tags = {

    Name      = each.key
    Terraform = "true"
  }

}


