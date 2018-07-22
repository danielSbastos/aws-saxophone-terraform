resource "aws_ecs_task_definition" "ecs-task-definition" {
  family                   = "saxophone-backend"
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "1024"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = <<DEFINITION
[
  {
    "essential": true,
    "image": "dbastos/saxophone-backend:1",
    "name": "saxophone-backend",
    "portMappings": [{
        "protocol": "tcp",
        "containerPort": 4000,
        "hostPort": 4000
    }]
  }
]
DEFINITION
}
