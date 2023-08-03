resource "aws_db_instance" "default" {
  identifier      = "mydb"
  engine          = "mysql"
  engine_version  = "5.7"
  instance_class  = "db.t2.micro"
  allocated_storage = 20
  username        = "foo"
  password        = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible = true
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.allow_mysql.id]
}



resource "aws_security_group" "allow_mysql" {
  name        = "allow_mysql"
  description = "Allow inbound and outbound MySQL traffic"

  ingress {
    description = "MySQL/Aurora"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_mysql"
  }
}

resource "null_resource" "createdb" {
  provisioner "local-exec" {
    command = "mysql -h ${aws_db_instance.default.address} -P 3306 -u ${aws_db_instance.default.username} -p${aws_db_instance.default.password} -e 'CREATE DATABASE Scopic-devops-db;'"
  }
  depends_on = [aws_db_instance.default]
}

