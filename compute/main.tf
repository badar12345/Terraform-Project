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

resource "aws_instance" "proxy" {
  count         = length(var.public_subnet_ids)
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_ids[count.index]
  vpc_security_group_ids = [var.proxy_sg_id]
  associate_public_ip_address = true

  tags = {
    Name        = "${var.environment}-proxy-${count.index + 1}"
    Environment = var.environment
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2",
      "echo '<html><body><h1>Proxy Server ${count.index + 1}</h1></body></html>' | sudo tee /var/www/html/index.html"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "echo 'proxy-ip${count.index + 1} ${self.public_ip}' >> all-ips-temp.txt"
  }
}

resource "aws_instance" "backend" {
  count         = length(var.private_subnet_ids)
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [var.backend_sg_id]

  tags = {
    Name        = "${var.environment}-backend-${count.index + 1}"
    Environment = var.environment
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<html><body><h1>Backend Server ${count.index + 1}</h1></body></html>" > /var/www/html/index.html
              EOF

  provisioner "local-exec" {
    command = "echo 'backend-ip${count.index + 1} ${self.private_ip}' >> all-ips-temp.txt"
  }
}