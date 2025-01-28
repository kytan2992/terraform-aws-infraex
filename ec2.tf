resource "aws_instance" "public" {
  ami                         = "ami-0df8c184d5f6ae949" #Challenge, find the AMI ID of Amazon Linux 2 in us-east-1
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet_a.id  #Public Subnet ID, e.g. subnet-xxxxxxxxxxx
  associate_public_ip_address = true
  key_name                    = var.key_name #Change to your keyname, e.g. jazeel-key-pair
  vpc_security_group_ids = [aws_security_group.terra-sg.id]
 
 user_data = <<-EOF
            #!/bin/bash
            yum update -y
            yum install -y httpd
            echo "<h1>Hello from public ec2</h1>" | sudo tee /var/www/html/index.html
            systemctl start httpd
            systemctl enable httpd
            EOF

  tags = {
    Name = "${ local.resource_prefix }-ec2-public"    #Prefix your own name, e.g. jazeel-ec2
  }

}

resource "aws_instance" "private" {
  ami                         = "ami-0df8c184d5f6ae949" #Challenge, find the AMI ID of Amazon Linux 2 in us-east-1
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet_c.id  #Public Subnet ID, e.g. subnet-xxxxxxxxxxx
  key_name                    = var.key_name #Change to your keyname, e.g. jazeel-key-pair
  vpc_security_group_ids = [aws_security_group.terra-sg.id]
  
  user_data = <<-EOF
            #!/bin/bash
            yum update -y
            yum install -y httpd
            echo "<h1>Hello from private ec2</h1>" | sudo tee /var/www/html/index.html
            systemctl start httpd
            systemctl enable httpd
            EOF

  tags = {
    Name = "${ local.resource_prefix }-ec2-private"    #Prefix your own name, e.g. jazeel-ec2
  }
  
}

output "ec2_public_ip" {
 value = aws_instance.public.public_ip
}