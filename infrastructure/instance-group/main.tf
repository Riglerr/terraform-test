provider "aws" {
  region = "eu-west-2"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

module "basic-container"{
  source = "git@github.com:riglerr/victor-aws-docker-basic"

  ami_id = "ami-083d1d468e31caa27"
  instance_group_name = "my-cluster"

  vpc_id = data.aws_vpc.default.id
  subnet_ids = data.aws_subnet_ids.default.ids

  listen_port = 80
  listen_protocol = "HTTP"

  server_port = 8080
  server_protocol = "HTTP"

  min_size = 1
  max_size = 2
}