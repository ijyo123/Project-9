resource "aws_db_instance" "my-p9sql-db" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "admin1"
  password             = "admin124"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.my-p9rds-db-subnet.id
}

#Create RDS subnet
resource "aws_db_subnet_group" "my-p9rds-db-subnet" {
  name       = "my-p9rds-db-subnet"
  subnet_ids = [aws_subnet.p9-privsub1.id, aws_subnet.p9-privsub2.id]

  tags = {
    Name = "my-p9rds-db-subnet"
  }
}

resource "aws_security_group" "my-p9rds-sg" {
  name        = "my-p9rds-sg"
  description = "Allow inbound traffic db"
  vpc_id      = aws_vpc.project9VPC.id
}

resource "aws_security_group_rule" "my-p9rds-sg-rule" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"
  ]
  
  security_group_id = aws_security_group.my-p9rds-sg.id
}

resource "aws_security_group_rule" "outbound_rule" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  security_group_id = aws_security_group.my-p9rds-sg.id
  cidr_blocks       = ["0.0.0.0/0"
  ]
}