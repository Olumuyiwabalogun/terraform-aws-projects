variable "myvpc" { 
  description = "This is the CIDR block for my VPC"
  type        = string
  default     = "10.0.0.1/24"
  }

  variable "environment" {
    description = "This is the environment for my VPC"
    type        = string
    default     = "Dev"
  }

  variable "name" {
    description = "This is the name for my VPC"
    type        = string
    default     = "NeosVPC"
  }

  variable "subnet_cidr" {
    description = "This is the CIDR block for my subnet"
    type        = string
  }
variable "route_dst_cidr_block" {
    description = "This is the destination CIDR block for my route"
    type        = string
  }
  variable "instance_type" {
    description = "This is the instance type for my EC2 instance"
    type        = string
    default     = "t2.micro"
  }

  variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true    # ← this hides it from logs and outputs
}