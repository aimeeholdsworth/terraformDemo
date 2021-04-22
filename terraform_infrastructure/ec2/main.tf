resource "aws_instance" "prod-instance" {
  ami               = var.ami_id 
  instance_type     = var.instance_type 
  availability_zone = var.av_zone 
  key_name          = var.key_name
  user_data = <<-EOF
                 #!/bin/bash
                 echo "export MYSQL_ROOT_PASSWORD=${var.MYSQL_ROOT_PASSWORD}">>~/.bashrc
                 echo "MYSQL_ROOT_PASSWORD=${var.MYSQL_ROOT_PASSWORD}">>~/.profile
                 echo "MYSQL_ROOT_PASSWORD=${var.MYSQL_ROOT_PASSWORD}">>/etc/environment


                 EOF

  network_interface {
    device_index         = 0
    network_interface_id = var.net_id_prod
  }

  #user_data = var.user_data

  tags = {
    Name = "prod"
  }
}

resource "aws_instance" "jenkins-instance" {
  ami               = var.ami_id 
  instance_type     = "t2.medium" 
  availability_zone = var.av_zone 
  key_name          = var.key_name
  user_data = <<-EOF
                 #!/bin/bash
                 echo "export MYSQL_ROOT_PASSWORD=${var.MYSQL_ROOT_PASSWORD}">>~/.bashrc
                 echo "MYSQL_ROOT_PASSWORD=${var.MYSQL_ROOT_PASSWORD}">>~/.profile
                 echo "MYSQL_ROOT_PASSWORD=${var.MYSQL_ROOT_PASSWORD}">>/etc/environment


                 EOF
  

  network_interface {
    device_index         = 0
    network_interface_id = var.net_id_jenkins
  }

 

  tags = {
    Name = "jenkins"
  }
}

resource "aws_instance" "test-instance" {
  ami               = var.ami_id 
  instance_type     = var.instance_type 
  availability_zone = var.av_zone 
  key_name          = var.key_name
  user_data = <<-EOF
                 #!/bin/bash
                 echo "export MYSQL_ROOT_PASSWORD=${var.MYSQL_ROOT_PASSWORD}">>~/.bashrc
                 echo "MYSQL_ROOT_PASSWORD=${var.MYSQL_ROOT_PASSWORD}">>~/.profile
                 echo "MYSQL_ROOT_PASSWORD=${var.MYSQL_ROOT_PASSWORD}">>/etc/environment


                 EOF
  

  network_interface {
    device_index         = 0
    network_interface_id = var.net_id_test
  }

 
  tags = {
    Name = "test"
  }
}


resource "aws_instance" "bastion-instance" {
  ami               = var.ami_id 
  instance_type     = var.instance_type 
  availability_zone = var.av_zone 
  key_name          = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.sec_group_id]
  

  # network_interface {
  #   device_index         = 0
  #   network_interface_id = var.net_id_bastion
  # }
  
 user_data = var.user_data
 
  tags = {
    Name = "bastion"
  }
}


resource "aws_db_instance" "sql-db" {
  identifier = "terrasqldb"
  allocated_storage    = 10
  
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "terrasqldb"
  username             = "admin"
  password             = var.MYSQL_ROOT_PASSWORD
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = var.subnet_group_name
  vpc_security_group_ids = [ var.sec_group_id_sql ]
  publicly_accessible   = false
  skip_final_snapshot  = true
  
}