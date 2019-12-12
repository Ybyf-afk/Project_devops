resource "aws_key_pair" "jenkins_key" {
  key_name = "jenkins_key"
  public_key = file("~/.ssh/nina.pub")
}
