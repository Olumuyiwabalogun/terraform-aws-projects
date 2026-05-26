output "cidr" {
    value = aws_vpc.neosvpc.cidr_block
  
}
output "vpc_id" {
    value = aws_vpc.neosvpc.id
  
}
output "vpc_arn" {
    value = aws_vpc.neosvpc.arn
  
}
output "subnet_id" {
    value = aws_subnet.neossubnet.id
  
}
output "subnet_arn" {
    value = aws_subnet.neossubnet.arn
  
}
output "subnet_cidr" {
    value = aws_subnet.neossubnet.cidr_block
  
}
output "internet_gateway_id" {
    value = aws_internet_gateway.neosigw.id
  
}
output "internet_gateway_arn" {
    value = aws_internet_gateway.neosigw.arn
  
}
output "route_table_id" {
    value = aws_route_table.neosroutetable.id
  
}   
output "route_table_arn" {
    value = aws_route_table.neosroutetable.arn
  
}
output "route_id" {
    value = aws_route.neosroute.id
  
}
output "route_destination_cidr_block" {
    value = aws_route.neosroute.destination_cidr_block
  
}
output "route_gateway_id" {
    value = aws_route.neosroute.gateway_id
  
}
output "route_table_association_id" {
    value = aws_route_table_association.neosroutetableassociation.id
  
}
output "security_group_id" {
    value = aws_security_group.neossg.id
  
}

output "ec2_instance_id" {
    value = aws_instance.neosinstance.id
  
}
output "public_ip" {
    value = aws_instance.neosinstance.public_ip
  
}

output "db_password" {
  value     = var.db_password
  sensitive = true    # ← hides it from terminal output
}
