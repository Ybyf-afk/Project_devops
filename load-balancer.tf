resource "aws_alb_target_group" "jenkins" {
  name = "jenkins"
  vpc_id = aws_vpc.devops.id

  port = 8080
  protocol = "HTTP"

  tags = {
    Name: "jenkins-target"
  }
}

resource "aws_alb_target_group_attachment" "jenkins-attachment" {
  target_group_arn = aws_alb_target_group.jenkins.arn
  target_id = aws_instance.jenkins.id
}

resource "aws_alb_target_group" "artifactory" {
  name = "artifactory"
  vpc_id = aws_vpc.devops.id

  port = 80
  protocol = "HTTP"

  tags = {
    Name: "artifactory-target"
  }
}

resource "aws_alb_target_group" "webapp" {
  name = "webapp"
  vpc_id = aws_vpc.devops.id

  port = 80
  protocol = "HTTP"

  tags = {
    Name: "webapp-target"
  }
}

resource "aws_alb" "devops-alb" {
  name = "devops-alb"
  subnets = [ aws_subnet.devops-public-1.id, aws_subnet.devops-public-2.id ]
  security_groups = [ aws_security_group.devops-alb.id ]

  tags  = {
    Name: "devops-alb"
  }
}

resource "aws_alb_listener" "http-listener" {
  load_balancer_arn = aws_alb.devops-alb.arn
  port = 80

  default_action {
    target_group_arn = aws_alb_target_group.webapp.arn
    type = "forward"
  }
}

resource "aws_alb_listener_rule" "jenkins-subdomain-rule" {
  listener_arn = aws_alb_listener.http-listener.arn

  action {
    target_group_arn = aws_alb_target_group.jenkins.arn
    type = "forward"
  }

  condition {
    field  = "host-header"
    values = ["jenkins.*.*"]
  }
}

resource "aws_alb_listener_rule" "artifactory-subdomain-rule" {
  listener_arn = aws_alb_listener.http-listener.arn

  action {
    target_group_arn = aws_alb_target_group.artifactory.arn
    type = "forward"
  }

  condition {
    field  = "host-header"
    values = ["artifactory.*.*"]
  }
}
