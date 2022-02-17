# SSM BU1
resource "aws_security_group" "endpoint_sg" {
  name        = "ssm-ec2-endpoints-sg"
  description = "Allow TLS inbound traffic for SSM/EC2 endpoints"
  vpc_id      = module.prod_backup.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.prod_backup.vpc.cidr]
  }
  tags = {
    Name = "sg-ssm-ec2-endpoints"
  }
}

resource "aws_vpc_endpoint" "ssm_endpoint" {
  vpc_id              = module.prod_backup.vpc.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.prod_backup.vpc.private_subnets[0].subnet_id]
  security_group_ids  = [aws_security_group.endpoint_sg.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssm_messages_endpoint" {
  vpc_id              = module.prod_backup.vpc.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.prod_backup.vpc.private_subnets[0].subnet_id]
  security_group_ids  = [aws_security_group.endpoint_sg.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ec2_messages_endpoint" {
  vpc_id              = module.prod_backup.vpc.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.prod_backup.vpc.private_subnets[0].subnet_id]
  security_group_ids  = [aws_security_group.endpoint_sg.id]
  private_dns_enabled = true
}