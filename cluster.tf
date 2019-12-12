resource "aws_ecs_cluster" "production" {
  name = "production_cluster"

  tags = {
    Name = "production_cluster"
  }
}

resource "aws_launch_configuration" "ecs-instance-launchconfig" {
  name_prefix = "ecs-instance-launchconfig"
  image_id = "ami-0ddeda5d6a02ce5cf"
  instance_type = "t3a.medium"
  spot_price = "0.023"
  key_name = aws_key_pair.jenkins_key.key_name
  iam_instance_profile = aws_iam_instance_profile.ecs-instance-profile.id
  security_groups = [aws_security_group.allow_ssh.id, aws_security_group.ecs-instance-devops.id ]
  user_data = <<EOF
    #!/bin/bash
    echo ECS_CLUSTER=${aws_ecs_cluster.production.name} >> /etc/ecs/ecs.config
    EOF
  lifecycle { create_before_destroy = true }
}

resource "aws_autoscaling_group" "ecs-instance-autoscaling" {
  name = ""
  vpc_zone_identifier = [ aws_subnet.devops-public-1.id ]
  launch_configuration = aws_launch_configuration.ecs-instance-launchconfig.name
  max_size = 1
  min_size = 1

  tag {
    key = "Name"
    value = "ecs-ec2-container"
    propagate_at_launch = true
  }
}
