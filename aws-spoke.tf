# ---------------------------------------------------------------------------------------------------------------------
# AWS Spoke 1
# ---------------------------------------------------------------------------------------------------------------------
module "aws_spoke_1" {
  source = "terraform-aviatrix-modules/mc-spoke/aviatrix"

  cloud         = "AWS"
  name          = "aws-spoke-1"
  cidr          = cidrsubnet(var.aws_supernet, 8, 211)
  region        = var.aws_region
  account       = var.aws_account
  transit_gw    = module.aws_transit_1.transit_gateway.gw_name
  insane_mode   = var.hpe
  instance_size = var.aws_instance_size
  ha_gw         = var.ha_gw

  depends_on = [module.aws_transit_1]
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Spoke 2
# ---------------------------------------------------------------------------------------------------------------------
module "aws_spoke_2" {
  source = "terraform-aviatrix-modules/mc-spoke/aviatrix"

  cloud         = "AWS"
  name          = "aws-spoke-2"
  cidr          = cidrsubnet(var.aws_supernet, 8, 212)
  region        = var.aws_region
  account       = var.aws_account
  transit_gw    = module.aws_transit_1.transit_gateway.gw_name
  insane_mode   = var.hpe
  instance_size = var.aws_instance_size
  ha_gw         = var.ha_gw

  depends_on = [module.aws_transit_1]
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS EC2
# ---------------------------------------------------------------------------------------------------------------------

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  name_regex  = "amzn2-ami-hvm*"
}

resource "aws_security_group" "aws_spoke_1_instance_sg" {
  name        = "aws-spoke-1/sg-instance"
  description = "Allow all traffic from VPCs inbound and all outbound"
  vpc_id      = module.aws_spoke_1.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "aws-spoke-1/sg-instance"
  }
}

resource "aws_instance" "aws_spoke_1_instance" {
  ami                    = data.aws_ami.amazon_linux_2.id
  subnet_id              = module.aws_spoke_1.vpc.private_subnets[0].subnet_id
  iam_instance_profile   = aws_iam_instance_profile.ssm_instance_profile.name
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.aws_spoke_1_instance_sg.id]

  user_data = <<EOF
#!/bin/bash
sudo sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
sudo systemctl restart sshd
echo ec2-user:${var.vm_admin_password} | sudo chpasswd
EOF

  tags = {
    Name = "backup-server"
  }
  #user_data = file("install-nginx.sh")
}

