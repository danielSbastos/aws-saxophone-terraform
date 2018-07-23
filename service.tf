resource "aws_ecs_service" "saxophone-backend" {
  name             = "saxophone-backend"
  cluster          = "${aws_ecs_cluster.ecs-cluster.id}"
  task_definition  = "${aws_ecs_task_definition.ecs-task-definition.arn}"
  desired_count    = 1
  launch_type      = "FARGATE"
  network_configuration {
    subnets          = ["subnet-cb9054f5", "subnet-cb9054f5"]
    assign_public_ip = true
    security_groups  = ["sg-3670ff7c"]
  }
}
