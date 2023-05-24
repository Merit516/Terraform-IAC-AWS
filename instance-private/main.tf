

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
resource "aws_instance" "my_instance_private" {
count          = length(var.private_subnet_ids)
  ami                    = data.aws_ami.ubuntu.id  # replace with your desired AMI ID
  instance_type          = "t2.micro"                # replace with your desired instance type
  key_name               = "my-key"                  # replace with your key pair name
  subnet_id              = var.private_subnet_ids[count.index] # replace with your desired subnet ID
  associate_public_ip_address = false                # assign a public IP address to the instance
  vpc_security_group_ids=[var.sg_id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              EOF

  tags = {
    Name = " ec2-private-name-${count.index + 1}"
  }

  
  

}