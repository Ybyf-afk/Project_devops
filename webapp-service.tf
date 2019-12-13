resource "aws_ecs_task_definition" "webapp_definition" {
  family = "webapp_definition"
  container_definitions = <<EOF
    [
    {
      "essential": true,
      "memory": 256,
      "name": "webapp",
      "cpu": 256,
      "image": "",
      "portMappings": [
      {
        "containerPort": 5050,
        "hostPort": 0
      }
      ]
    }
  ]
  EOF
}

resource "aws_ecs_service" "webapp_service" {
  name = "webapp_service"
  cluster = aws_ecs_cluster.production.id
  task_definition = aws_ecs_task_definition.webapp_definition.id
  desired_count = 1
  //  iam_role = ""
  //  depends_on = []
  //  lifecycle {
  //    ignore_changes = ["task_definition"]
  //  }
  load_balancer {
    target_group_arn = aws_alb_target_group.webapp.arn
    container_name = "webapp"
    container_port = 5050
  }

  depends_on = [ aws_alb.devops-alb ]
}
