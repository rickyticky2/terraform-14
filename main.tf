provider "aws" {
  # Configure the AWS Provider
   access_key = "AKIAZIYW7O7VDHGXAD4I"
   secret_key = "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"
   region      = "us-east-2"
}


resource "aws_instance" "my_Ubuntu" {
  ami = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  key_name   = "aazw"
  vpc_security_group_ids = [aws_security_group.my_servers.id]
  user_data = <<EOF
#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
echo "webserver ubuntu by Terraform." > /var/www/html/index.html
sudo systemctl start nginx
EOF
  }


resource "aws_security_group" "my_servers" {
  name        = "my_security group"
  description = "my_security group 1"
  #vpc_id      = aws_vpc.main.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }



  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}

