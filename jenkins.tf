resource "aws_instance" "jenkins" {
  instance_type = "t2.micro"
  ami = "ami-05f37c3995fffb4fd"
  key_name = aws_key_pair.jenkins_key.key_name
  
  subnet_id = aws_subnet.devops-public-1.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_tomcat.id]
  
  connection {
    host = aws_instance.jenkins.public_ip
    user = "ec2-user"
    private_key = file("~/.ssh/nina")
  }

  provisioner "file" {
    source = "./jenkins-install.sh"
    destination = "/tmp/jenkins-install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/jenkins-install.sh",
      "/tmp/jenkins-install.sh",
    ]
  }

  tags = {
    Name = "jenkins-master"
  }
}
