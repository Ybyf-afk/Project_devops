resource "aws_ecs_task_definition" "artifactory_definition" {
  family = "artifactory_definition"
  container_definitions = <<EOF
    [
    {
      "essential": true,
      "memory": 2048,
      "name": "artifactory",
      "cpu": 1024,
      "image": "950156722127.dkr.ecr.eu-west-2.amazonaws.com/test:artifactory-1.0",
      "portMappings": [
      {
        "containerPort": 8081,
        "hostPort": 0
      }
      ],
      "ulimits": [
              {
                "softLimit": 10000,
                "hardLimit": 10000,
                "name": "nofile"
              }
            ]
    }
  ]
  EOF
}

resource "aws_ecs_service" "artifactory_service" {
  name = "artifactory_service"
  cluster = aws_ecs_cluster.production.id
  task_definition = aws_ecs_task_definition.artifactory_definition.id
  desired_count = 1

  load_balancer {
    target_group_arn = aws_alb_target_group.artifactory.arn
    container_name = "artifactory"
    container_port = 8081
  }

  depends_on = [ aws_alb.devops-alb ]
}
