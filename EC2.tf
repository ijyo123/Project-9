resource "aws_instance" "webserver1-p9" {
  ami           = var.ami-id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.SG-HTTP-P9.id]
  subnet_id =  aws_subnet.p9-pubsub1.id
  availability_zone = "eu-west-2a"
  user_data         = file("install_apache.sh")

  tags = {
    Name = "HelloWorld-user"
  }
}

resource "aws_instance" "webserver2-p9" {
  ami           = var.ami-id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.SG-HTTP-P9.id]
  subnet_id =  aws_subnet.p9-pubsub2.id
  availability_zone = "eu-west-2b"

  tags = {
    Name = "HelloWorld-user"
  }
}