# resource "aws_iam_role" "ecs-service-role" {
#   assume_role_policy = ""
# }

# resource "aws_iam_role_policy_attachment" "ecs-service-role-attachment" {
#   role = aws_iam_role.ecs-service-role
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
# }
