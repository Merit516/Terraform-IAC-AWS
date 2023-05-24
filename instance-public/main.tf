

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
resource "aws_instance" "my_instance_public" {
count          = length(var.public_subnet_ids)
  ami                    = data.aws_ami.ubuntu.id  # replace with your desired AMI ID
  instance_type          = "t2.micro"                # replace with your desired instance type
  key_name               = "my-key"                  # replace with your key pair name
  subnet_id              = var.public_subnet_ids[count.index] # replace with your desired subnet ID
  associate_public_ip_address = true                # assign a public IP address to the instance
  vpc_security_group_ids=[var.sg_id]

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      # Replace nginx configuration with local configuration
      "sudo sed -i \"52 i proxy_pass http://${var.private_loadbalancer_dns};\" /etc/nginx/sites-available/default",
      "sudo systemctl restart nginx"
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./merit-iti.pem")
    host        = self.public_ip
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> ./instacne_public_ips.txt"
  }



  tags = {
    Name = "ec2-public-name-${count.index + 1}"
  }
}