
# ============================
# MUMBAI: DEFAULT VPC
# ============================

data "aws_vpc" "mumbai_default" {
  default = true
}

data "aws_subnets" "mumbai_default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.mumbai_default.id]
  }
}

# Amazon Linux 2023 AMI
data "aws_ami" "mumbai_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ============================
# VIRGINIA: DEFAULT VPC
# ============================

data "aws_vpc" "virginia_default" {
  provider = aws.virginia
  default  = true
}

data "aws_subnets" "virginia_default" {
  provider = aws.virginia

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.virginia_default.id]
  }
}

# Ubuntu 24.04 LTS AMI
data "aws_ami" "virginia_ubuntu" {
  provider    = aws.virginia
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    ]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ============================
# EC2: MUMBAI
# ============================

resource "aws_instance" "mumbai_ec2" {
  ami           = data.aws_ami.mumbai_linux.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnets.mumbai_default.ids[0]

  tags = {
    Name        = "terraform-ec2-mumbai"
    OS          = "Amazon Linux 2023"
    Environment = "lab"
  }
}

# ============================
# EC2: VIRGINIA
# ============================

resource "aws_instance" "virginia_ec2" {
  provider      = aws.virginia
  ami           = data.aws_ami.virginia_ubuntu.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnets.virginia_default.ids[0]

  tags = {
    Name        = "terraform-ec2-virginia"
    OS          = "Ubuntu 24.04 LTS"
    Environment = "lab"
  }
}
