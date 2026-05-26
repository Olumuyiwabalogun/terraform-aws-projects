# Terraform AWS Projects

## What this repo contains
Hands-on Terraform practice projects building real AWS infrastructure.

## Projects
- VPC + Subnet + Internet Gateway
- Security Groups
- EC2 Instance with Apache web server
- Multiple environments (dev + prod)

## Infrastructure built
- VPC with public subnet
- Internet Gateway + Route Table
- Security Group (ports 80, 443, 22)
- EC2 Instance serving a real webpage

## How to use
1. Clone the repo
2. Create your own tfvars file
3. Run terraform init
4. Run terraform plan -var-file="your.tfvars"
5. Run terraform apply -var-file="your.tfvars"

## Requirements
- Terraform >= 1.0
- AWS CLI configured
- AWS account