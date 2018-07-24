resource "aws_ecs_cluster" "cluster" {
  name = "saxophone-cluster"
}

resource "aws_ecs_task_definition" "task-definition" {
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

resource "aws_ecs_service" "service" {
  name             = "saxophone-backend"
  cluster          = "${aws_ecs_cluster.cluster.id}"
  task_definition  = "${aws_ecs_task_definition.task-definition.arn}"
  desired_count    = 1
  launch_type      = "FARGATE"

  network_configuration {
    subnets          = ["subnet-cb9054f5", "subnet-cb9054f5"]
    assign_public_ip = true
    security_groups  = ["${aws_security_group.security-group.id}"]
  }
}

resource "aws_security_group" "security-group" {
  name        = "allow_port_400"
  description = "Allow inbound traffic from port 4000"
  vpc_id      = "${data.aws_vpc.vpc.id}"

  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
