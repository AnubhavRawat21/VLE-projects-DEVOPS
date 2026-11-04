terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

variable "instance_id" {
  description = "Existing EC2 instance ID"
  type        = string
}

data "aws_instance" "existing" {
  instance_id = var.instance_id
}

output "existing_instance_id" {
  value = data.aws_instance.existing.id
}

output "existing_instance_type" {
  value = data.aws_instance.existing.instance_type
}

output "existing_instance_public_ip" {
  value = data.aws_instance.existing.public_ip
}
