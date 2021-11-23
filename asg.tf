resource "aws_launch_configuration" "elb9_launch_config" {
  image_id      = var.ami-id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.SG-HTTP-P9.id]

  user_data =<<-EOF
              #!/bin/bash
              yum -y install httpd
              echo "Hello, from Terraform" > /var/www/html/index.html
              service httpd start
              chkconfig httpd on
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg_project9" {
  name                 = "autoscaling"
  launch_configuration = aws_launch_configuration.elb9_launch_config.id
  min_size             = 2
  max_size             = 5
  health_check_grace_period = 300
  health_check_type = "ELB"
  desired_capacity = 4
  force_delete = true
  vpc_zone_identifier = [aws_subnet.p9-pubsub1.id, aws_subnet.p9-pubsub2.id ]

}