data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type[terraform.workspace]

  user_data = file("bootstrap.sh")

  key_name = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [
    aws_security_group.terraform_sg.id
  ]

  tags = {
    Name = "${terraform.workspace}-server"
  }
}